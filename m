Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF088721
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 02:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHJALk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 20:11:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHJALk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 20:11:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so40390335pgc.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 17:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=EuQ/R3CppOBh2T1D6FSE6/gAUMLd+emlPXZ8P0KlK4E=;
        b=KECCdmknzaH0Ve1akzRhLGqPfYzLSqiQZzqIGqUTh+SAcO6Q19ScBeUTVGmT9Kn2fi
         wuc/H+9Zvt1RiYlS2YMjELwda9ElQG3tetwgpwSLKyc3GMze7p3oJ/iAFf+mlr04fS3p
         4SoG8g9Vg49LMc+XN9CN2yjxwMYkHbcBup94eMKinNVLCmVJIOstAPR1bTlg+BvjkpIY
         cd36ZXrgFEWiqQp6BRzMLy0rpNVl0ji479pxHPF2OWsm4aIthkJshQrCEUBBzGGR6KqN
         xCB5+OxoXjeEhzq/eUA6LgN2F98/tP71hoMrI7Rz306vlRZd504t0Hj1N10xjJOIG5GQ
         EZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EuQ/R3CppOBh2T1D6FSE6/gAUMLd+emlPXZ8P0KlK4E=;
        b=EVFyOPeUNRo35MZkGLUo21wNI4nmbSWTd4UWNeLzqm/ZaTIkNmdijNyaZ0UbiWiZSR
         6+WDNjBd3HHeL90YjshhFviSLKfNx8q4r2b/DH7wbjZCA6d12U+fHyXGHL4ZUzky6rox
         sShnpqe1BBQ830NgOocODLU/ICK9D4HV+YtpGErD6vv2qCV6/7ty0PMkjfaM4HDUWmxk
         bdN1Ouelr9FlM0V1PiH5DK60sE4vW1IjpAFutcHTp8h+l2IlAdbi6gRKv/wo/dAHmvC9
         tsxBYXxgQOQGcDiMPxzAR38Jg3Ts2sM4oTg38CmQMfBGbJ/YtbZlPZwhjbi8HgYENaPJ
         n8YA==
X-Gm-Message-State: APjAAAWJVDUkQ5nWeB31nR4mCUf67kOLj7IJAB9Me63iBpZVQTIwb0fp
        C2ohFRCYo+mkABXvRtrulER35Q==
X-Google-Smtp-Source: APXvYqwfo3bJUKvTH7g4ZfJhFp6Q9sQXhh6NsNs21MEaB/aVJYLW2l4lX40Zlrs3JJt56T2EbsbNBA==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr24770723pfd.8.1565395899475;
        Fri, 09 Aug 2019 17:11:39 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b873:707a:e893:cdb3])
        by smtp.gmail.com with ESMTPSA id k14sm25201452pgb.78.2019.08.09.17.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 17:11:38 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <20190806130506.8753-1-glaroque@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com>
Date:   Fri, 09 Aug 2019 17:11:37 -0700
Message-ID: <7hd0hd3mme.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> This patchs series add support of New Amlogic temperature sensor and minimal
> thermal zone for SEI510 and ODROID-N2 boards.
>
> First implementation was doing on IIO[1] but after comments i move on thermal framework.
> Formulas and calibration values come from amlogic.
>
> Changes since v2:
>   - fix yaml documention 
>   - remove unneeded status variable for temperature-sensor node
>   - rework driver after Martin review
>   - add some information in commit message
>
> Changes since v1:
>   - fix enum vs const in documentation
>   - fix error with thermal-sensor-cells value set to 1 instead of 0
>   - add some dependencies needed to add cooling-maps
>
> Dependencies :
> - patch 3,4 & 5: depends on Neil's patch and series :
>               - missing dwc2 phy-names[2]
>               - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]
>
> [1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
> [2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
> [3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
> [4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
> [5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/

Thank you for the detailed list of dependencies!  Much appreciated.

With all the deps, I tested this on sei510 and odroid-n2, and basic
functionality seems to work.

As discussed off-list: it would be nice to have an example of how
cpufreq could be used as a cooling device for hot temperatures.  The
vendor kernel has some trip points that could be included as examples,
or even included as extra patches.

Also the driver patch is missing the two main thermal maintainers, so
please resend at least the driver and bindings including them.


Kevin
