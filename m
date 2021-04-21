Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89D5366675
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhDUHwA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 03:52:00 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43806 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbhDUHv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 03:51:59 -0400
Received: by mail-lf1-f45.google.com with SMTP id y4so25304504lfl.10;
        Wed, 21 Apr 2021 00:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=Pae9yH+KaHgTqO+dxMFR9Vep9F1PrK7GQlrKbtuE/kI=;
        b=CvAbYW+Bz8Sj728WpXFetqW6sVK536wmR4oKurUcMkA5erGaameUl3ZXR/dsx1IHVk
         1/ziMfI6Fk7n6yt5RanH+ee6XkzzrH0AzzAqemNA0mVQL4ZYTTKMmunzDkWE474NHYfO
         v6/k1OiWTPbtwQZkKrFe8z/QlKfsI5SMTT1kxa+0PM++P7m+HQBcxEdylz1HXYU3oKxr
         x1XRtJehMNQ/qw1ybvAb8Wd2hPLhfz+HRWpDu1oVf0ABhThuSf8xSPXjI25XHEHcbM3l
         2mQp+RtJv21wmYAYjOgOZkpX3UwG27lAgXPoODN5lpmXZLboiA5Fy9mAg9c4Wf0R81qh
         YeKw==
X-Gm-Message-State: AOAM533MPIw2QPOojvjLQv9Cf6tfDktk2az+9p0Qw+ac3LtqVaZHy3YF
        hrIKN10BL5XtYdSoNNuEnco=
X-Google-Smtp-Source: ABdhPJyamlH7tMymKn/NliNVTaRv5+NWeF4lqRMi91V4eNBUtbjHXg0IbpR8KG2YkoC6zBsccN0XWg==
X-Received: by 2002:ac2:4e8c:: with SMTP id o12mr16152092lfr.211.1618991485123;
        Wed, 21 Apr 2021 00:51:25 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id c18sm125078ljd.66.2021.04.21.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:51:24 -0700 (PDT)
Message-ID: <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
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
In-Reply-To: <YFn5CSB1O3i+SzgR@kroah.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
         <YFn5CSB1O3i+SzgR@kroah.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 21 Apr 2021 10:51:13 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 2021-03-23 at 15:19 +0100, Greg KH wrote:
> On Tue, Mar 23, 2021 at 02:58:28PM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 3/23/21 2:56 PM, Matti Vaittinen wrote:
> > > Devm helper header containing small inline helpers was added.
> > > Hans promised to maintain it.
> > > 
> > > Add Hans as maintainer and myself as designated reviewer.
> > > 
> > Ultimately this is up to Greg though, so lets wait and see what
> > Greg has to say about this.
> 
> Can we move some of the devm_* calls in include/device.h into here as
> well so that you all can be in charge of them instead of me?

Seems like this was left w/o answer. I guess the question was pointed
to Hans - but what comes to my (not always so humble) opinion - most of
the devm functions in device.h are tightly related to the device
interface or devres. Thus the device.h feels like appropriate place for
most of those. OTOH, the kmalloc/kfree related functions, strdub and
kmemdub might be candidates for move - those are not really "device
things".

But this is really not my call :)

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND


