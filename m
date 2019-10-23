Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B50E208A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407256AbfJWQ0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 12:26:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43280 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404669AbfJWQ0b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 12:26:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id j33so3489265ota.10;
        Wed, 23 Oct 2019 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EAeizC7dUymc6uqIjtz5jyoFjB5RNX3davj32nJWlag=;
        b=eSVKJPPSrxkfXuHWE0N6bFOTDmX4LGsHHVQcIk6qNzDrNfvL0D431RQT5BrQp9Mej+
         +esFGeEsSIY+RZzJcJGxgfxIRWgE5gSKWHI+YZ6uT9wXF38Jo43sb5mSYNELJCHdTW1p
         eXIhe7NpJ8aEnZB6o6j+zasHLKgF8Pt0nTA0ui/+A10OBmAH15RKeimEIptjE/YfKWq9
         kPLOj9nbUVnvaFtC7AoAr577+VENuOTy16j/F9zdfVv2JXW5j/FoInQDyfaUZIuy7qCR
         HY0XIqGceqsOaww6Noi+0MMFYS/j7D3JE0F4FpUn+hM3UtAM9lj+divH+QNsm2j8bjRK
         isng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EAeizC7dUymc6uqIjtz5jyoFjB5RNX3davj32nJWlag=;
        b=JVqjFHeYuvLblfYa/0Izh2S71b0nC3CQvvdkxhKdofhwC37SYayVo7c5izVjv6UhMC
         hpoRRgZKGe2mbYlBLqihXkn63LM+E2295fU8bKeIpCCXpw32MrencTYYmHx1Jfs7Pg4a
         ZUzShaw68D4+ywntyNjCK5/pyI4UadqOVJe+KSydeOR7YyZwN6VIudORA0ox8MKj1Zfz
         Abr9BojMAY4iJNJW+iwsGGhsJ0KdLILtG7gr4w1+INV6vbLs/N/11/LfQ6BrAN2NYw1Y
         w79egGP0WA0qVfO1rzH1QnaaHt1N117UgHH4pIoJFQnSHjC2MdksLpSKK574zbIbMyAb
         2IXA==
X-Gm-Message-State: APjAAAXfj697yBx19QQdGd1UHihajUrW/hGmJgeKd+mWGerL74XCLOQ+
        RcaqTxMb0NkuL+Xk65XBiK4=
X-Google-Smtp-Source: APXvYqxGGHjlYhN0aCecroWTpgfM2cdkJJ4tljItbCQ5HKCIO85N4Hy2T18gE58ANs4ielIxOJ6sEw==
X-Received: by 2002:a05:6830:1685:: with SMTP id k5mr8411180otr.203.1571847990325;
        Wed, 23 Oct 2019 09:26:30 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k19sm5688229oiw.31.2019.10.23.09.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 09:26:29 -0700 (PDT)
Date:   Wed, 23 Oct 2019 09:26:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] cpufreq: s3c64xx: Remove pointless NULL check in
 s3c64xx_cpufreq_driver_init
Message-ID: <20191023162628.GA10997@ubuntu-m2-xlarge-x86>
References: <20191023000906.14374-1-natechancellor@gmail.com>
 <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
 <20191023104304.GA5723@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023104304.GA5723@sirena.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 11:43:04AM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 08:53:02AM +0530, Viresh Kumar wrote:
> > On 22-10-19, 17:09, Nathan Chancellor wrote:
> > > When building with Clang + -Wtautological-pointer-compare:
> > > 
> > > drivers/cpufreq/s3c64xx-cpufreq.c:152:6: warning: comparison of array
> > > 's3c64xx_freq_table' equal to a null pointer is always false
> > > [-Wtautological-pointer-compare]
> > >         if (s3c64xx_freq_table == NULL) {
> > >             ^~~~~~~~~~~~~~~~~~    ~~~~
> > > 1 warning generated.
> > > 
> > > The definition of s3c64xx_freq_table is surrounded by an ifdef
> > > directive for CONFIG_CPU_S3C6410, which is always true for this driver
> > > because it depends on it in drivers/cpufreq/Kconfig.arm (and if it
> > > weren't, there would be a build error because s3c64xx_freq_table would
> > > not be a defined symbol).
> 
> > +broonie, who wrote this patch to see his views on why he kept it like
> > this.
> 
> The driver should also have supported s3c6400 as well.

Kconfig says otherwise, unless I am missing something.

config ARM_S3C64XX_CPUFREQ
        bool "Samsung S3C64XX"
        depends on CPU_S3C6410
        default y
        help
          This adds the CPUFreq driver for Samsung S3C6410 SoC.

          If in doubt, say N.

Cheers,
Nathan
