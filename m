Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE53DB154
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407690AbfJQPnp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 11:43:45 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46336 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJQPno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 11:43:44 -0400
Received: by mail-pf1-f178.google.com with SMTP id q5so1888878pfg.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VOvV2/r2ynt55cnuM6fNik0rL8EihZtai79HG+PQGYs=;
        b=epCRTxPcIzW1JK1hav0kYxQFV4/KtoeRzGuJPSEcPwm+07F5s+hclMNoXvQqf4/Xn1
         PHRKmwonpyafnqMNOi9dcJPoPWnD3ya7CTnu9Qry/TzAB4HpaKOrbK0R0qaDDbOiEQuc
         NAMjpGaz/LGOeUnEU04tjxWY9G5Za9Eys1QYmuHKt94WBRAaXPRhFZjOql8+NYkH3ors
         UfFt5ENN2F9lK41nMVEmg+Mu/70pL+aDZgePCLsFDjUW2Ci+iy3EgWg4J7mRQpCA0hge
         OOvt2UsggArcB7npbmFQA0cehGx67F4L0qjr14Beidi0Rt1MqMZm6SjLMBOoC32THmyd
         CsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VOvV2/r2ynt55cnuM6fNik0rL8EihZtai79HG+PQGYs=;
        b=j7zSvErXehVrcuc9Qkw7Jgx1JiFg46yvRqAz+JWUkDj+bhehCokJS59asTQPmsC1p9
         1kk32+FBUebt+IPGxn2aAcjUL6BlD2PXvIo9rDdET4867LyC5XSC6oJ6xUgIgM/3Y8OF
         eEs2MGkaSR5KmIYofhFYQdqnpeh7k7YYyJOgHggZ8oDoWECErI5i5Uxv2vFJMjHb+H3f
         SIC6axoSK1VRe0zb4JbWaXw8fvUqX0/KnrQY7XTXR2nFqX5ZyP4ZT3CtIu/61vZV0YYc
         igIWKgQ2E8G+cam+j9kdoypd9pHHrri/2vjod5f7zcvuk6fiyR+CBhB+h7LGPxr90AdK
         eOYQ==
X-Gm-Message-State: APjAAAVVs4gPl5XLGpKL71lXx2oky8cr2R5rcixNXMArWvBAgH+ftE4V
        hNRP8PdeNDWzXqPfb/42+VYvNw==
X-Google-Smtp-Source: APXvYqwBC3rv9yHdPPniodMnf3ve5F6d/VBydNViIQXvnFmqx0IoTgB6MJOo2TPQ1KZma6BcLkaNWA==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr5226930pjb.44.1571327022410;
        Thu, 17 Oct 2019 08:43:42 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:d8f2:392e:5b44:157d])
        by smtp.gmail.com with ESMTPSA id f14sm3987624pfq.187.2019.10.17.08.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 08:43:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com
Subject: Re: [PATCH v7 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <9ade0e3e-1bd7-c49b-44b1-2361f1e3a7b1@linaro.org>
References: <20191004090114.30694-1-glaroque@baylibre.com> <7hwod4fxwb.fsf@baylibre.com> <9ade0e3e-1bd7-c49b-44b1-2361f1e3a7b1@linaro.org>
Date:   Thu, 17 Oct 2019 08:43:41 -0700
Message-ID: <7h36frcr82.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 16/10/2019 18:39, Kevin Hilman wrote:
>> Eduardo,
>> 
>> Guillaume La Roque <glaroque@baylibre.com> writes:
>> 
>>> This patchs series add support of New Amlogic temperature sensor and minimal
>>> thermal zone for SEI510 and ODROID-N2 boards.
>> 
>> [...]
>> 
>>> Guillaume La Roque (7):
>>>   dt-bindings: thermal: Add DT bindings documentation for Amlogic
>>>     Thermal
>>>   thermal: amlogic: Add thermal driver to support G12 SoCs
>>>   arm64: dts: amlogic: g12: add temperature sensor
>>>   arm64: dts: meson: g12: Add minimal thermal zone
>>>   arm64: dts: amlogic: g12a: add cooling properties
>>>   arm64: dts: amlogic: g12b: add cooling properties
>>>   MAINTAINERS: add entry for Amlogic Thermal driver
>> 
>> This has now been thorougly reviewed/tested.
>> 
>> I've queued all the "arm64: dts:" patches via my amlogic tree for v5.5.
>> Can you please queue up the driver, bindings and MAINTAINERS patch?
>
> 1, 2, 7 right?

Correct.

Thanks,

Kevin
