Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84E9869E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfHUVaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 17:30:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42879 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfHUVaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 17:30:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so2081652pgb.9
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JamKzvdT5n0JRFMyDQS1FT/k6bVQThWvvzDjprEJ6CY=;
        b=iMJnFRHDKKfY2TVix6Kg7QyOZkDIj5MTwOzwwrn9Yh0Quv6TKjoaBAZkhZHd1kOHee
         LXYDawRhFHEgBNVxflMeMS/vKJFbK02GEskP/b6ppziRxRi71zF0RENhjAVb7LQCWOtV
         CHhrElk4aIvJMy7kf/RDsJ3S7caNHIVvHYd+xe2R1sU6oYZpkGVwZCAfBXtXXFTrXwvg
         AVFLU7xkUCQi9Uk9PR83GQaRgRbRYRgV+B9KFifQie13IcraLry4MNr3OCU0avrjxreC
         K2PcHaPYxhKddpS94bCbVgYQ2dv1df8KAJmlVi0wYxdGfp48vGlzZyybK6pyDqhS7qmA
         HZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JamKzvdT5n0JRFMyDQS1FT/k6bVQThWvvzDjprEJ6CY=;
        b=oYhBrN5Hj9jdrpncfo89NLKT2hmTljzdrPW7q3DBAnE/C5d+hrRMmXD9eqXD/eDw5R
         ydUzPBuv4xeqvdYYxq/Z7cjkNLXwxkv4lUfFWjouElUegft6QkNxXDDJCwdsOEMiMJI6
         +2VyEC+6st8U8fhNXG7FiyAe6OuD+hBeVYr2xPOq7rtToX8FB4/sWczNUdjU7TTGmrmj
         PgqYUgA/j59aeKo1PJgXQcj3EKr5oJhBIoNVgCzY18tclN5w537G9VNo4reL/5EWDUvo
         6hGfI4pqeKOkNU64eNwoEtiIHaAFVgn9tYy/bnZ48+pq4YpGDiy5I65QtbpRaC64ND0W
         54EA==
X-Gm-Message-State: APjAAAUVN8x5QNsJPV2zG2BNpQ7/pGcKyoWrAykfZs+CKuEJN8zcnNwO
        AFuRZb2OOXgYzDTxIRaByG1W0U+shv8MkA==
X-Google-Smtp-Source: APXvYqxJgS3AGYB65QX2eSGKbfHabg/mZAuaZCmr2wu/yKCdqUmPctixFz2Q12im4wy2hl85+1FtNA==
X-Received: by 2002:a63:5a4d:: with SMTP id k13mr30104074pgm.174.1566423018409;
        Wed, 21 Aug 2019 14:30:18 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id a128sm24706235pfb.185.2019.08.21.14.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 14:30:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <7hd0hd3mme.fsf@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com> <7hd0hd3mme.fsf@baylibre.com>
Date:   Wed, 21 Aug 2019 14:30:17 -0700
Message-ID: <7himqq9pg6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Guillaume La Roque <glaroque@baylibre.com> writes:
>
>> This patchs series add support of New Amlogic temperature sensor and minimal
>> thermal zone for SEI510 and ODROID-N2 boards.
>>
>> First implementation was doing on IIO[1] but after comments i move on thermal framework.
>> Formulas and calibration values come from amlogic.
>>
>> Changes since v2:
>>   - fix yaml documention 
>>   - remove unneeded status variable for temperature-sensor node
>>   - rework driver after Martin review
>>   - add some information in commit message
>>
>> Changes since v1:
>>   - fix enum vs const in documentation
>>   - fix error with thermal-sensor-cells value set to 1 instead of 0
>>   - add some dependencies needed to add cooling-maps
>>
>> Dependencies :
>> - patch 3,4 & 5: depends on Neil's patch and series :
>>               - missing dwc2 phy-names[2]
>>               - patchsets to add DVFS on G12a[3] which have deps on [4] and [5]
>>
>> [1] https://lore.kernel.org/linux-amlogic/20190604144714.2009-1-glaroque@baylibre.com/
>> [2] https://lore.kernel.org/linux-amlogic/20190625123647.26117-1-narmstrong@baylibre.com/
>> [3] https://lore.kernel.org/linux-amlogic/20190729132622.7566-1-narmstrong@baylibre.com/
>> [4] https://lore.kernel.org/linux-amlogic/20190731084019.8451-5-narmstrong@baylibre.com/
>> [5] https://lore.kernel.org/linux-amlogic/20190729132622.7566-3-narmstrong@baylibre.com/
>
> Thank you for the detailed list of dependencies!  Much appreciated.
>
> With all the deps, I tested this on sei510 and odroid-n2, and basic
> functionality seems to work.
>
> As discussed off-list: it would be nice to have an example of how
> cpufreq could be used as a cooling device for hot temperatures.  The
> vendor kernel has some trip points that could be included as examples,
> or even included as extra patches.
>
> Also the driver patch is missing the two main thermal maintainers, so
> please resend at least the driver and bindings including them.

Forgot to add...

Tested-by: Kevin Hilman <khilman@baylibre.com>
