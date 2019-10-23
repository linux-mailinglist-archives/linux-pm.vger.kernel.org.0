Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E245E214A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfJWRDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 13:03:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38820 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfJWRDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 13:03:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id e11so18045694otl.5;
        Wed, 23 Oct 2019 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LNIlo875oLUnbVBAslOcAnj59hqK1kHx858TCXge7cA=;
        b=N4mOPS98IWbZY/2/KBp62o4U8DpmiY8K/DxEPJzcpUxxxheeFNhUu7vukEldTwgqYR
         rHqct06pgkkgI7CxlYFrLPVZFWX0enc8m766N5KPfidbuNpOhSlOnf7lUm4GpzbTXhqi
         mKxKG1Y07F9CS+p9fzQ9CFIozlQSEzIVJiYzQjPfo6BpMzEDSObuiZoB7x9je0fp6S0/
         DyL2E/W6hxxWsJfr0QGpj9uWjDA0V25V2YCZx82kOEZYyAZ8gLMmecgtPLXiTgUOyeY+
         X9ZQcx5xLJl2//NB9fL0WDdd6hfY1K67a98OMzhy12qY9cFN8oW7zGfw3Oiphk5MZUXX
         LNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNIlo875oLUnbVBAslOcAnj59hqK1kHx858TCXge7cA=;
        b=MNvc3Vph9kmIvuS0C8x2xUpu81uNJgC/oeQ3V5vx/tpkXM4PwilMxsxQgS2X2Drg+1
         jOU3bc2yEHqHM4s97HW3IF4E200n3kXt1+nUzcNHo2Njrsq9VBAzaC2OCio8Vgt0egge
         nb63icvMU5Bui6SsPTco4uGpixoY1LDqqj0RkgegvJDX1Mpb2C6F1jNaa0hv/eIZHk4w
         8KhX/tphdeM6WPEG8XlJO7hpipgh7Rgow0ZB6eMxBi35vdwOUrj8prrwLygckeW0Qewm
         BwX6vfzIAyfS6H0eTUuUF/IyF6s5GwpK8PoBaqGkA463UTDceAubckB037kX/6+bGmhI
         Rk5g==
X-Gm-Message-State: APjAAAVavtALCw53b/h//ReV5tJXX0OzBvasy3cYEOYqzF/TOsmalBm+
        2icab+bE7uWmuJ1+DLTFKoQ=
X-Google-Smtp-Source: APXvYqyr+KOjBV2W0qrTz7k8vKZIZRshNryK06zDkLhWk6XYcHe9LOVkSReS/D2+RnKymZPKRqgmvQ==
X-Received: by 2002:a9d:6ace:: with SMTP id m14mr8170163otq.11.1571850184682;
        Wed, 23 Oct 2019 10:03:04 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r26sm5705285oij.46.2019.10.23.10.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 10:03:04 -0700 (PDT)
Date:   Wed, 23 Oct 2019 10:03:02 -0700
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
Message-ID: <20191023170302.GA45373@ubuntu-m2-xlarge-x86>
References: <20191023000906.14374-1-natechancellor@gmail.com>
 <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
 <20191023104304.GA5723@sirena.co.uk>
 <20191023162628.GA10997@ubuntu-m2-xlarge-x86>
 <20191023163656.GH5723@sirena.co.uk>
 <20191023165417.GA15082@ubuntu-m2-xlarge-x86>
 <20191023165923.GL5723@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023165923.GL5723@sirena.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 05:59:23PM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 09:54:17AM -0700, Nathan Chancellor wrote:
> > On Wed, Oct 23, 2019 at 05:36:56PM +0100, Mark Brown wrote:
> > > On Wed, Oct 23, 2019 at 09:26:28AM -0700, Nathan Chancellor wrote:
> > > > On Wed, Oct 23, 2019 at 11:43:04AM +0100, Mark Brown wrote:
> 
> > > > > The driver should also have supported s3c6400 as well.
> 
> > > > Kconfig says otherwise, unless I am missing something.
> 
> > > Note the XX in the config option.
> 
> > But what about the depends and the help text?
> 
> Viresh asked why the driver was written with s3c6410 support optional.
> I explained that the reason that it was written this way was to
> accomodate s3c6400 support.

Ah understood, thanks for the clarification and sorry for the
misunderstanding!

Cheers,
Nathan
