Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0391412CAF6
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2019 22:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfL2VSM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Dec 2019 16:18:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40781 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfL2VSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Dec 2019 16:18:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so12780802wmi.5;
        Sun, 29 Dec 2019 13:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AzclGfOCXNAFhVFAqVBZxuEHKEXk4tM/YU8j/8O1+hs=;
        b=lLXBgiKMMyD7FokQ2U/JUSDBMZFzOQoIKCgHNI+60AGG2ilT5T2fPG8yYN3suuMKin
         Ot4fwogQYRhL1id4XrGEOtBHY9Gn5q9jIFuhDFeEqnOr1DHcfut+J/0XHaXrCDsc3ASO
         UMWEBAfm4VSlIr+LCTkZUb0qhrj76kPYpboGv5on7vqBrECTTvO8i1E+Xx1Pp/on0yf9
         QGFRQ1s9tbhkRQNcZOptghoOob6+dWxH4uVGf9WtwU/LeDqkZ8ZOwePRRP87wk7QybhX
         PAnMrPunncO6eeN33A/zL3WIKuUV2zu5LBpnasEFZi73W4YBMaFQDjlzcAfo0YcMMpXL
         q6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AzclGfOCXNAFhVFAqVBZxuEHKEXk4tM/YU8j/8O1+hs=;
        b=XJfENpoXt2Z4sn5f7DHtFeXeycwfJHXvRVCxYA3z9kV1v1ayqfb48K8FgCQvn5gqaX
         rlKsJtmRLi5wIm5vwc8XGyjvuyPEy90uLX3msc4nzZa76/n76jXsjRR1uPRrmciTmInI
         MWv3YbIrFmSNh0xJSm01032e07eI2XiJXkABwbOkTMqZSE5PLIZvvrBRvwm0x024mLOJ
         N7sjjbhLzCapeNc2kRb9CAbH+RxWtKqzrUriLTb2cXghz0d0Y/uwYJh+qx1L6eGxObSa
         IqVqqqnhAyo1DHGu13M0tk+LIgcRY00CLZMPjTJRp32xUjpSpGZcji66NdHx1F24RqDI
         /WSw==
X-Gm-Message-State: APjAAAW+NzcXbo2FMnQOlzg4+8eecOD9mSq0QUK67dtVWGm4Vd2DVPTn
        9IGracs1BR2gihCRAz+8w7k=
X-Google-Smtp-Source: APXvYqwe4j7BCJKoNmzgx6G5UOUHUdaOfUj1LA5ALQmFsCT3xRlnki75ehUVZZ75w3+5DilW8p5V+Q==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr31728708wma.5.1577654289600;
        Sun, 29 Dec 2019 13:18:09 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id d8sm43791504wre.13.2019.12.29.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 13:18:08 -0800 (PST)
Date:   Sun, 29 Dec 2019 22:18:05 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191229211805.GA26718@Red>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
 <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
 <20191226104419.GA26677@Red>
 <CAEExFWtNZM3QSSMEksK=-opKZqxvCqyG2=3=iCo3VU6tfie64w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWtNZM3QSSMEksK=-opKZqxvCqyG2=3=iCo3VU6tfie64w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 26, 2019 at 08:47:47PM +0800, Frank Lee wrote:
> On Thu, Dec 26, 2019 at 6:44 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > On Thu, Dec 26, 2019 at 10:27:51AM +0100, Maxime Ripard wrote:
> > > On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> > > > On 19/12/2019 18:33, Maxime Ripard wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > > > >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > > > >> H6 and R40 SoCs.
> > > > >
> > > > > Thanks again for working on this.
> > > > >
> > > > > I'll merge the DT patches when the driver will have been merged.
> > > >
> > > > I've applied patches 1 & 2.
> > > >
> > > > They are in the testing branch and will go to the linux-next branch as
> > > > soon as the kernelci passes.
> > >
> > > I just merged all the other patches (except the patch 6, for the H6,
> > > as requested by Vasily on IRC).
> > >
> >
> > Hello
> >
> > Vasily asked to not apply H6 due to my test failling on h6 and since he didnt own any H6 hw.
> > But it was failling due my fault (a failling build).
> >
> > So the patchset work perfect on H6 (opi1+, opi3, pineH64 both model A and B) as reported by my answer to this thread.
> 
> HI Corentin,
> 
> Although it is not calibrated, it should work on the R40. Can you give
> my patch a try?
> 
> Thx，
> Yangtao
> 

Hello

It works:
uname -a
Linux zlad 5.5.0-rc2-next-20191220+ #196 SMP PREEMPT Sun Dec 29 22:08:05 CET 2019 armv7l ARMv7 Processor rev 5 (v7l) Allwinner sun8i Family GNU/Linux
cat /sys/devices/virtual/thermal/thermal_zone0/temp
30736
cat /sys/devices/virtual/thermal/thermal_zone0/type 
cpu0-thermal
cat /sys/devices/virtual/thermal/thermal_zone1/temp
29380
cat /sys/devices/virtual/thermal/thermal_zone1/type 
gpu-thermal

So you could add to your patch:
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-r40-bananapi-m2-ultra

thanks
Regards
