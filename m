Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7855E8D186
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfHNKw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 06:52:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36844 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNKw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 06:52:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so16915208wrt.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+ay8dxtqKOmRhpRA7J2tC2kQsvZ//Wog5MpD7s+WHk=;
        b=YIzNwjTQo0CWHIYhxk5e90h2RIQCPkvtfJtttFQcWU7Fkov+Wsw4kNxz9gFbQwlpx0
         C4dbmI0UlP4aF0I2ShEel2YqPvWvrgiEeNPLlR+ruSRTSVF63F5zutggq6iZMoLZRZqh
         +2Z+EHlggO96DNn236kXb5GkXwzf4TJUJCTKSiuhpi7++/zDdVtycCbPs/pFSTP3V0nW
         e3NoH/TrNzyE5pDr3T9aZlOqx5mSCb0mEMGAe0StvaB+gnmjRpFXef1l2NADEHc4l9h3
         86vI4idKm5CyjNVjXM/Bk2lfLCU/1lYBPY49oUi+q5A3oPLjSYba00VNpndFYMG1lF+H
         14+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V+ay8dxtqKOmRhpRA7J2tC2kQsvZ//Wog5MpD7s+WHk=;
        b=WlkpLrx0VNmeiQUppln3LEEKqvOKZ73B+STIJwPgv2K3qlD6EoAucr81v4PX6mDryX
         ziDChaZpw6b7LySjRIleB79Chs+EbJGr/sZTbSAfIs9sbWuIoktqoVOHIQln3b7T9GIv
         GEuLKCzNwPeKH19ovsSdgLdCiZTVmzKZOPijjLs78jPM+/mixw2nAdNeZuPs97eA6ODq
         txoE/I3rApZ3AL36/tcOtG3NOOw/hltNuDWPQdmYXe4VBbg267hbAJKo/H87tle5w1ub
         0DW8trtQYp1ICh+8xc1GtUBDWFLSVCkfgyRWtThMKj75c5UVMoXjmdAYyc91e/QMEWrH
         re4A==
X-Gm-Message-State: APjAAAWHueaALmG+MZ2wuy4+dxzyN9nCs4QLrpxp+cJY9GqJyymioEVs
        pyFCuA5/8Hh+2wMn2aDkLAVk/w==
X-Google-Smtp-Source: APXvYqwnRdTMaWXakISmqiw3vZTumeWfXQsXh6YM/7O8MWnJNnfquWH+FvQX2PKDVic8evLkwtLsSQ==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr29237095wrn.184.1565779973890;
        Wed, 14 Aug 2019 03:52:53 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b148:137c:80f1:4062? ([2a01:e34:ed2f:f020:b148:137c:80f1:4062])
        by smtp.googlemail.com with ESMTPSA id n14sm219823960wra.75.2019.08.14.03.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 03:52:46 -0700 (PDT)
Subject: Re: [PATCH 0/4] qcom: Model RPMH power domains as thermal cooling
 devices
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <efe98b11-9b79-4ecb-5e28-2a62235cf56c@linaro.org>
Date:   Wed, 14 Aug 2019 12:52:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Thara,

interesting series. Can you describe what use case this series will solve?

On 10/08/2019 02:58, Thara Gopinath wrote:
> Certain RPMH power domains can be used to warm up the SoC (mx on sdm845)
> if the temperature falls below certain threshold. 

What is the relationship between the temperature fall, the sensor(s)
location and the warming device(s) in this case?


> These power domains
> can be considered as thermal warming devices
> (opposite of thermal cooling devices).

Is it possible to elaborate how works the RPMH as a warming device and
what is the "mx on sdm845"?

> In kernel, these warming devices can be modeled as a 
> thermal cooling device. To use these power domains as warming devices
> require further tweaks in the thermal framework which are out of scope
> of this patch series.
> 
> The first patch in this series extends the genpd framework to export out
> the performance states of a power domain so that when the RPMH power
> domain is modeled as a cooling device, the number of possible states and
> current state of the cooling device can be retrieved from the genpd
> framework.
> 
> The second patch implements the newly added genpd callback for RPMH power
> domain driver.
> 
> The third patch implements the modeling of a RPMH power domain as
> a cooling device and the final patch adds the device node entry for sdm845
> to consider RPMHPD MX a cooling device.
> 
> Thara Gopinath (4):
>   PM/Domains: Add support for retrieving genpd performance states
>     information
>   soc: qcom: rpmhpd: Introduce function to retrieve power domain
>     performance state count
>   thermal: qcom: Add RPMHPD cooling device driver.
>   arm64: dts: qcom: Extend AOSS RPMHPD node
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    |   7 ++
>  drivers/base/power/domain.c             |  38 +++++++++
>  drivers/soc/qcom/rpmhpd.c               |  11 +++
>  drivers/thermal/qcom/Kconfig            |   7 ++
>  drivers/thermal/qcom/Makefile           |   1 +
>  drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141 ++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h               |  18 ++++
>  7 files changed, 223 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

