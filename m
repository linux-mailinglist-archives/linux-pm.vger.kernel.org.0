Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451A1E2114
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfJWQyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 12:54:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43038 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfJWQyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 12:54:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id s5so2601653oie.10;
        Wed, 23 Oct 2019 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQ6HtKFRVKwkx70dv6lhY5+sv55++939i+kxJIbYQOk=;
        b=XwqTEbh83WUk9swwM+S6MduBQYUxV1UnqpAXzdKB3NHcdnBNjHgAjwZCEBCq3OS0Bh
         GjZg/QQsOqt87xgcrBHXuz4vYGnC9U1Hj3lWGaS53rLGdMpvE0J0ycin9HPETlHF5qCi
         wuQ3zFKUwaijdeDJK68QnYuvrB9Nn04OxF9cIbI3RtPpFF9dTF+nwmGk88xry3rW8lgo
         cuZTNIwELXwQPjQh+rqoEOkNQF6SGAjuBUZwfTFrPbF7mTl21peNPDHnlXz9LW42oV12
         Jgxryp4LkCb72DUjN2sHDVVjJuQL5z27QTfFuFzTzM1KbHB7n4G63IZGpvcL6K7toM/g
         phBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQ6HtKFRVKwkx70dv6lhY5+sv55++939i+kxJIbYQOk=;
        b=QEABoq1CYsMDygydsB7u518iDZVZneZGF+vKWIHxQWov++iOwpOgD4joz1Dfw+eHPA
         D7dEw3oLjyQjj8Pc4h+DspRTFVJALCzs7GYtTm/v0LXh00KcpHkv076wDIG+JCGZeGde
         CihT7OCl+XDzDCy+lDvkJDqE/fPyp/D4Q28SYvHQMXSJClwJ55K97Y9WmWVF7j4EUltx
         TeRdmUnQKEHW63zwIteN32ZUHXnIs7hEwVW75jNWXVSBjzEzBn7/Yn5YNw7aUee597KD
         /3usCv/f8MzDWoT7McyTxE96syuRUoAE3Z/veleCp4SjJvq53dchTpEcMY/24d+s1vGi
         qH7Q==
X-Gm-Message-State: APjAAAUupYgEuLv/dC0xewK7UqYTSGc/KozyqgPyCxnQ12XxU+DatGFJ
        GVZxNvy84/d9REEGE5U9iVI=
X-Google-Smtp-Source: APXvYqxH8dH2sQQliq9O/qFxXaaYdDo1CANEBZgRu2OntBGDnoOtV1DAe3ZPTpbdtQ3m8TSxljUstw==
X-Received: by 2002:aca:5007:: with SMTP id e7mr736105oib.123.1571849659358;
        Wed, 23 Oct 2019 09:54:19 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y16sm6186987otg.7.2019.10.23.09.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 09:54:18 -0700 (PDT)
Date:   Wed, 23 Oct 2019 09:54:17 -0700
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
Message-ID: <20191023165417.GA15082@ubuntu-m2-xlarge-x86>
References: <20191023000906.14374-1-natechancellor@gmail.com>
 <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
 <20191023104304.GA5723@sirena.co.uk>
 <20191023162628.GA10997@ubuntu-m2-xlarge-x86>
 <20191023163656.GH5723@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023163656.GH5723@sirena.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 05:36:56PM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 09:26:28AM -0700, Nathan Chancellor wrote:
> > On Wed, Oct 23, 2019 at 11:43:04AM +0100, Mark Brown wrote:
> 
> > > The driver should also have supported s3c6400 as well.
> 
> > Kconfig says otherwise, unless I am missing something.
> 
> > config ARM_S3C64XX_CPUFREQ
> >         bool "Samsung S3C64XX"
> >         depends on CPU_S3C6410
> >         default y
> >         help
> >           This adds the CPUFreq driver for Samsung S3C6410 SoC.
> > 
> >           If in doubt, say N.
> 
> Note the XX in the config option.

But what about the depends and the help text?

If I just enable the following config options in multi_v7_defconfig and
remove that depends, the driver will not build because the {dvfs,freq}_table
definitions only get added to the final source file when CONFIG CPU_S3C6410 is
set...

CONFIG_ARCH_MULTI_V6=y
CONFIG_ARCH_S3C64XX=y
CONFIG_MACH_SMDK6400=y

  CC      drivers/cpufreq/s3c64xx-cpufreq.o
../drivers/cpufreq/s3c64xx-cpufreq.c:61:13: error: use of undeclared identifier 's3c64xx_freq_table'
        new_freq = s3c64xx_freq_table[index].frequency;
                   ^
../drivers/cpufreq/s3c64xx-cpufreq.c:62:29: error: use of undeclared identifier 's3c64xx_freq_table'
        dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_data];
                                   ^
../drivers/cpufreq/s3c64xx-cpufreq.c:62:10: error: use of undeclared identifier 's3c64xx_dvfs_table'
        dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_data];
                ^
...
14 errors generated.

So maybe it _should_ support s3c6400 but it does not appear to, which
is why there is this clang warning that my patch is trying to address.

If I am missing something critical, please let me know.

Cheers,
Nathan
