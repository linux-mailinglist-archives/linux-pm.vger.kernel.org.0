Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF398D8C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfHVIXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 04:23:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35940 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfHVIXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 04:23:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so4533185wrt.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pdSEt99/CAmqV4fLv18bovPaZEVnOI86pAE/GZZ1s8o=;
        b=G8PGFUZfNXXmilf161dMeUTcpEBj+qTrlmsTnkGZuXZyum2+F9+g8Uj4QM9Ou+A/+z
         QlSOh3eqahxos/JE8qqoby3HAWtEadv0K7tJAHNg3vMTkCoOh9MMuE3/JkaBnPsv19Mu
         Zc+47ASy/6fCfJEiM1+2V3ttMKInkjAkWSrnkl5UrW1k38gmLEbCRA43mKcj1U9BGUdG
         O8kr+27+CSQ41Yw7KCkv0UwP2zfK+fHMqINg8PtnUMk/s2tO0TNrhRpKSqRH0TJfXBFl
         lw1RU1aTNxbVSoBqMwR+r5akQOdWyYCo+QJ2DqoNOma+h0JJE5G4L7xpgRCZPHaZKMh9
         kbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pdSEt99/CAmqV4fLv18bovPaZEVnOI86pAE/GZZ1s8o=;
        b=LPclfnTc1b6X+nUb1HTJmlfmu5Tr7toKKngLTOFb4suLi5CBZIwpOcM8f3A/MLDb6s
         fg6eReS/C1ye8nQxdT6tHwsxYarUm74XO+HkHX0CAPnwaORNIXgL2pmGtoNzwoGwVCER
         JPdTSCRw0MoKJWEmdGulRpfyi726RVogM5lb9bbBa1s+FXY/mDxL8eZvJRvdZOOYHC2w
         WkktuLBa1fMH8EtNcBYpxFaAuTwIcENvX1FuKGjBmsi8Qd88XihGUZe9FWK2cNpVc2Xf
         CpxINLTdx4p1xvLVHj2dkxIZtV8vHnAFTT0RHWDzlL/oGe0SyT09Qz7QLQ/MJry1PO/L
         GfTg==
X-Gm-Message-State: APjAAAU03r999YEzO4r7eq0oSbNcVgIEhfiFB8fW3PKfagdCZTtBrOIS
        2iCJaRHigvthza+V+oU70ft6Cw==
X-Google-Smtp-Source: APXvYqxZAhFzPIllWHgOfm1YJnUgWV3//Of7Tq/vW5OyikIqSWVvyroTMOmPiwWv1xAe+2JPFgJNSw==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr992885wrb.261.1566462213455;
        Thu, 22 Aug 2019 01:23:33 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f134sm4484687wmg.20.2019.08.22.01.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 01:23:32 -0700 (PDT)
Subject: Re: [PATCH 4/5] arm64: dts: meson-sm1-sei610: add HDMI display
 support
To:     Kevin Hilman <khilman@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190821114121.10430-1-narmstrong@baylibre.com>
 <20190821114121.10430-5-narmstrong@baylibre.com>
 <7ho90i5c41.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <09a5372b-3ff1-b6fc-9a06-d8f9c235e763@baylibre.com>
Date:   Thu, 22 Aug 2019 10:23:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7ho90i5c41.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/08/2019 01:31, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> Update compatible of the pwc-vpu node and add the HDMI support nodes
>> for the Amlogic SM1 Based SEI610 Board.
> 
> I think this changelog is out of date.  It's not doing anything with the
> VPU pwrc node.

Exact, thanks for pointing it

> 
> Kevin
> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-sm1-sei610.dts     | 23 +++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>> index 12dab0ba2f26..66bd3bfbaf91 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>> @@ -51,6 +51,17 @@
>>  		};
>>  	};
>>  
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_connector_in: endpoint {
>> +				remote-endpoint = <&hdmi_tx_tmds_out>;
>> +			};
>> +		};
>> +	};
>> +
>>  	leds {
>>  		compatible = "gpio-leds";
>>  
>> @@ -177,6 +188,18 @@
>>  	phy-mode = "rmii";
>>  };
>>  
>> +&hdmi_tx {
>> +	status = "okay";
>> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
>> +	pinctrl-names = "default";
>> +};
>> +
>> +&hdmi_tx_tmds_port {
>> +	hdmi_tx_tmds_out: endpoint {
>> +		remote-endpoint = <&hdmi_connector_in>;
>> +	};
>> +};
>> +
>>  &i2c3 {
>>  	status = "okay";
>>  	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
>> -- 
>> 2.22.0

