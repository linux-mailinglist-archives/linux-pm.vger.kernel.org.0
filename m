Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE033329F4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhCIPPH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhCIPOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:14:40 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708DC06174A;
        Tue,  9 Mar 2021 07:14:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id t16so13115464ott.3;
        Tue, 09 Mar 2021 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CoPe10wguFXwv3/ydJS6p2Kjhu16+mc1rW6ZkeWWHc8=;
        b=ItAedlJzt/oJL4OJXf668TlbTxtv36IlRzlJcF3Q6nUZwFrWZX5RtaAIXJWv/0BqEq
         /XinWTOkkcHCkJoddzmcnj890fg/l9Y2WICSCMA32pi4ho+toMkEdpriF+2GIKH2V6TX
         noi6P7w7a3Z27pw4wz7w/90aqp/bMcb0saKtAp1pI4a4rkmYxVl8lxowZ0XWMePVu/a8
         gsgcCumom6KlJkTMppMwjLYJS6UZcCnfKkFniXHgdAMBnxiCELBtZCo1YCG/HpuR84hf
         oDSKhBvYgwQv215FUoOQo+0HGZRTSWp5SuFF7zWDjushFgRLc0KdTLne51IyCJTw2A+n
         W75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CoPe10wguFXwv3/ydJS6p2Kjhu16+mc1rW6ZkeWWHc8=;
        b=CpQHgo5a45GbxBQ2hgRlhNrvR+4KYmdaIhiwc4GQGGyxczugFHTJ4qt7IUeqyzLu9c
         /Nx51ybn2au1Vnf39V7P+WoZZMsfysBiq0cyfgi5FXkXFOKrZahhIoXtTFYkvnDt1aGI
         ukf8IOErr68kIpuKGlt3PGFInR9TB4iHLJvQZD+w3KBu2iWWp/Nbbr/c+tEqkCD5cO/7
         h2W1mnv4qLSfdxm2nBlZRcTNnUqh+UJQvBgk1EQudbR0cUfZJeT/GeSNHjGtLZcX5qj7
         Wmoir16i6zG+WfThu/bh+3RAiMDRju3jHNyayCv9eEziNtTg0uerHsmY99MgefNP8D3N
         Wdbg==
X-Gm-Message-State: AOAM530Oa/m8+kuF5lSoJy0sgjRwdXaNUAdUZP1fO07B7dco++eZp1ar
        Ux3mWdNJqkM8dEyLyGVODcyHMp3yNq8zxqCwvAU=
X-Google-Smtp-Source: ABdhPJz/9WEWu5Vn12lWGJUpod4XmOCfX9tjjMYE/Ae1aVmqOJnlj0VdR1lBTPvsjnBDPEdQB8GpZarKdRjlpykxyR4=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr9233998otk.118.1615302879997;
 Tue, 09 Mar 2021 07:14:39 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-3-git-send-email-aisheng.dong@nxp.com> <c5f27c46-f1a0-cd19-3bec-3dd8800b2cae@gmail.com>
In-Reply-To: <c5f27c46-f1a0-cd19-3bec-3dd8800b2cae@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 9 Mar 2021 23:14:39 +0800
Message-ID: <CAA+hA=RTEZq68opa4N1SZB-uo__+8PkN9HTBa1+scODBQPFtiw@mail.gmail.com>
Subject: Re: [PATCH 02/11] PM / devfreq: remove the invalid description for get_target_freq
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 9, 2021 at 11:02 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > First of all, no_central_polling was removed since
> > commit 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices
> > which can idle")
> > Secondly, get_target_freq() is not only called only with update_devfreq=
()
> > notified by OPP now, but also min/max freq qos notifier.
> >
> > So remove this invalid description now to avoid confusing.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/governor.h | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> > index 70f44b3ca42e..5cee3f64fe2b 100644
> > --- a/drivers/devfreq/governor.h
> > +++ b/drivers/devfreq/governor.h
> > @@ -57,8 +57,6 @@
> >    *                  Basically, get_target_freq will run
> >    *                  devfreq_dev_profile.get_dev_status() to get the
> >    *                  status of the device (load =3D busy_time / total_=
time).
> > - *                   If no_central_polling is set, this callback is ca=
lled
> > - *                   only with update_devfreq() notified by OPP.
> >    * @event_handler:      Callback for devfreq core framework to notify=
 events
> >    *                      to governors. Events include per device gover=
nor
> >    *                      init and exit, opp changes out of devfreq, su=
spend
> >
>
> As I replied from patch1, I recommend that squash it with patch1.

Got it, i will squash when sending the next version.
Thanks

Regards
Aisheng

>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
