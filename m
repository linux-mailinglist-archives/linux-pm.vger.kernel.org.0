Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77811987E8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfHUXcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 19:32:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45951 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHUXcA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 19:32:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so2214568plr.12
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VOlbPmuVW0UlC0yrc6l1Ece7msX8P0YAAbmbTsWvE6k=;
        b=I5S/d4SZjPzdz35NUNswb6iBNJ1AWdtObOn29esBipz+R87RKlEolWGL6riFl7CdOV
         v1NEaRIWpbg7yCKlvsJJSkUcW3Xb1xklCcNQybKSHF007ns/7be30rF1DN3YAUz35U4f
         i/zyN/1KpR+RXnZmlwJhYVsU5GhVYTKAbpabjj6d7PAZzcah4i72+1r8SmP5zOW50ATv
         XEA34X6ob5jY/85TUuVDf0cM/l/DQsFEo5kVfHSUmKlSefvJTy2OhvCUjrg5nylofRvt
         I6a2krbyCliXa9XlsJdnoCgTDwSCLGs3ZurtnIOhu5zNbcftg/GNBXwHJqpYemrj2p/h
         jQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VOlbPmuVW0UlC0yrc6l1Ece7msX8P0YAAbmbTsWvE6k=;
        b=qevpzUHtC1uzdaSI8+x0aIqYLXxIYAlaM3yolkwaog8CxVwNu1PbJoHTHU0NUmb5NG
         FRmS/8N+SZBhOZZMTMsMICeipPqnuTnGfgkFWs/Efsb/120PPmlwGrQYpMLO/hRZVCSo
         eTbijNzmd0wOuNHil1i7va1/VRx+XHi56z8ABirBQnLSB6jb83g1NhVQ1vOVXwE+8k6x
         C4o4vooQYnWDdxEkXFIrOTDBs0AGZrUMCEjQboYqQt4ltawDm7g6xgOxJ0oFmbimSSDR
         32Kf2qD0GsAGYMsiFjX4lMRcOz5Znt4JWRpYJEfEGxFpk8ADYHa7NGC//3q4KmdDrqHz
         EpSQ==
X-Gm-Message-State: APjAAAVkxkgIyRa/jErrsSazmSbr9c0YdcK3Aayosrf0Km3VqHUnE8gi
        b2rNlyFBlSeCqc+azJ5TgIRXwA==
X-Google-Smtp-Source: APXvYqwAlor0zKX5PdZk/Ir/r+5HEyYcJpkCr33V81VSFu+AJaD46KXgavZ3ATTtWp9OBJZXEvZwsQ==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr34596141plq.274.1566430319944;
        Wed, 21 Aug 2019 16:31:59 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e13sm30367654pfl.130.2019.08.21.16.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:31:59 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: meson-sm1-sei610: add HDMI display support
In-Reply-To: <20190821114121.10430-5-narmstrong@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com> <20190821114121.10430-5-narmstrong@baylibre.com>
Date:   Wed, 21 Aug 2019 16:31:58 -0700
Message-ID: <7ho90i5c41.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Update compatible of the pwc-vpu node and add the HDMI support nodes
> for the Amlogic SM1 Based SEI610 Board.

I think this changelog is out of date.  It's not doing anything with the
VPU pwrc node.

Kevin

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-sm1-sei610.dts     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> index 12dab0ba2f26..66bd3bfbaf91 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> @@ -51,6 +51,17 @@
>  		};
>  	};
>  
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -177,6 +188,18 @@
>  	phy-mode = "rmii";
>  };
>  
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
>  &i2c3 {
>  	status = "okay";
>  	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> -- 
> 2.22.0
