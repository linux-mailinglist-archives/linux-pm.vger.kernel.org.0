Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123CD64C19
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfGJSab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 14:30:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfGJSab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 14:30:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BA5D128B47D
Message-ID: <85fb2cb764961845a32b8af51e8c6ccebf60c703.camel@collabora.com>
Subject: Re: [PATCH v2] PM / devfreq: Fix kernel oops on governor module load
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     cwchoi00@gmail.com
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, kernel@collabora.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date:   Wed, 10 Jul 2019 15:30:23 -0300
In-Reply-To: <CAGTfZH3WenT=t6bFWy7sZCKhcPaMBrzTs=00DeSFU-0Sm-qS=A@mail.gmail.com>
References: <20190621213949.27018-1-ezequiel@collabora.com>
         <CAGTfZH3WenT=t6bFWy7sZCKhcPaMBrzTs=00DeSFU-0Sm-qS=A@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Chanwoo,

On Sat, 2019-06-22 at 19:46 +0900, Chanwoo Choi wrote:
> Hi,
> 
> 2019년 6월 22일 (토) 오전 6:42, Ezequiel Garcia <ezequiel@collabora.com>님이 작성:
> > A bit unexpectedly (but still documented), request_module may
> > return a positive value, in case of a modprobe error.
> > This is currently causing issues in the devfreq framework.
> > 
> > When a request_module exits with a positive value, we currently
> > return that via ERR_PTR. However, because the value is positive,
> > it's not a ERR_VALUE proper, and is therefore treated as a
> > valid struct devfreq_governor pointer, leading to a kernel oops.
> > 
> > Fix this by returning -EINVAL if request_module returns a positive
> > value.
> > 
> > Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_then_request_governor")
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> > Changes from v1:
> > * Rework the fix as suggested by Enric and Chanwoo,
> >   handling the return vaue.
> > ---
> >  drivers/devfreq/devfreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 6b6991f0e873..258f70c1e48f 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
> >                 /* Restore previous state before return */
> >                 mutex_lock(&devfreq_list_lock);
> >                 if (err)
> > -                       return ERR_PTR(err);
> > +                       return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
> > 
> >                 governor = find_devfreq_governor(name);
> >         }
> 
> Thanks you for fix-up.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> But, you are missing the stable mailing list. In order to apply this
> fix-up patch,\
> you have to send it to stable mailing list. Please send it.
> 
> 

If I understand correctly, you or any of the devfreq maintainer
can simply add a Cc: stable@vger.kernel.org tag.

This is documented as Option 1 in stable-kernel-rules.rst.

The Acked-by and Reviewed-by tags need to be collected anyway :-)

Thanks!
Eze

