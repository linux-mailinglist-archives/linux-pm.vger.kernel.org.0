Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0301366AF8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhDUMkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 08:40:01 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:35472 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhDUMkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 08:40:01 -0400
Received: by mail-lj1-f169.google.com with SMTP id a1so47545223ljp.2;
        Wed, 21 Apr 2021 05:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=gqXlkCgkYaliKzSIWWiqMC/IObZSimqK6blKlGamzt8=;
        b=MjSjqb76TZCSZPN4c6ylN4YjlBVX0pzQT9xSD3bnq+z/SGBK1DDh3i36mGyX9A62fs
         4KD+7yldDYg9rQgPaLS9dzao8hyoHhRAphqvN8cPS2Az7o528DzUrYWP4NCsbRyiSY3n
         jQwqzGbYAIzQ+rawzUYzjDsHpVN+sLkNOTiAHoKX5bWYVFw7J23eBIMM3e7QD/kJBt47
         4A+bhnjFO0xcJrnvH7t+K8dEIcGnJbBeXr1EPzuqzFDGnKIKJ2OTm3PXSY649zGl7pf6
         fsSmM/e+8V8Dg/5c1NXkubk2y9OJUmcDuiiacrnipBkrfyr94KCA9axv7aoCeyP6DtCY
         I5Jg==
X-Gm-Message-State: AOAM530/6PDn9FN0W6aRcbQ/VSQ9kj94NsHEx+xIUkmAAyT+DRJduehW
        Dbb28bg0JA7qWnKfZJdlgEk=
X-Google-Smtp-Source: ABdhPJw3/RkVjq9noLJkB2WxlU+bq4IxABCOIusPe7WLNrAQk2hoF1MqF84JVSrLW/RyZluVvLF5lA==
X-Received: by 2002:a2e:b819:: with SMTP id u25mr17586377ljo.105.1619008765334;
        Wed, 21 Apr 2021 05:39:25 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id u16sm201678lja.48.2021.04.21.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:39:24 -0700 (PDT)
Message-ID: <f131569c39ac4bbef0ac6b83e009470a43088c60.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Greg KH <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <YIAWDh5tMl607kHv@kroah.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
         <YFn5CSB1O3i+SzgR@kroah.com>
         <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
         <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
         <YIAWDh5tMl607kHv@kroah.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 21 Apr 2021 15:39:19 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 2021-04-21 at 14:09 +0200, Greg KH wrote:
> On Wed, Apr 21, 2021 at 01:58:29PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 4/21/21 9:51 AM, Matti Vaittinen wrote:
> > > On Tue, 2021-03-23 at 15:19 +0100, Greg KH wrote:
> > > > On Tue, Mar 23, 2021 at 02:58:28PM +0100, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 3/23/21 2:56 PM, Matti Vaittinen wrote:
> > > > > > Devm helper header containing small inline helpers was
> > > > > > added.
> > > > > > Hans promised to maintain it.
> > > > > > 
> > > > > > Add Hans as maintainer and myself as designated reviewer.
> > > > > > 
> > > > > Ultimately this is up to Greg though, so lets wait and see
> > > > > what
> > > > > Greg has to say about this.
> > > > 
> > > > Can we move some of the devm_* calls in include/device.h into
> > > > here as
> > > > well so that you all can be in charge of them instead of me?
> > > 
> > > Seems like this was left w/o answer. I guess the question was
> > > pointed
> > > to Hans
> > 
> > I believe that Greg was (mostly) joking here. At least that is how
> > I interpreted Greg's reply,which is why I did not answer.
> 
> I have no idea what this thread was about anymore, sorry :)

Need more B12 ;) Can't remember a minor discussion just a few thousand
other patch mails ago? Huh, that's what the age does, right :p

Well,
this is not urgent in any way but here's some context:

> This series implements delayed wq cancellation on top of devm and
> replaces
> the obvious cases where only thing remove call-back in a driver does
> is
> cancelling the work. There might be other cases where we could switch
> more than just work cancellation to use managed version and thus get
> rid
> of remove or mixed (manual and devm) resource management.
> 
> The series introduces include/linux/devm-helpers.h file which
> hopefully works as a place where this kind of helpers can be inlined.

and your reply:

>  Can we move some of the devm_* calls in include/device.h into here
> as well ...

I thought you meant that literally, Hans assumed you were joking - and
you don't remember how it was :] So - if no further suggestions, then
we keep the devm stuff which is currently in device.h still in
device.h. Although the malloc/free stuff is not really strictly device
thing.


Best Regards
	Matti Vaittinen

