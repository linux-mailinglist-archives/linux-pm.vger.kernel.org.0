Return-Path: <linux-pm+bounces-1578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BD81E50A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Dec 2023 06:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CE11C214E9
	for <lists+linux-pm@lfdr.de>; Tue, 26 Dec 2023 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF684B14C;
	Tue, 26 Dec 2023 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kb4bslvc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF74B12F
	for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2023 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d099d316a8so3937046b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Dec 2023 21:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703569010; x=1704173810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wt8Y6H9UYhlcK+Kq+g9t/n5C3ulwRlQUCahaLJRULwM=;
        b=kb4bslvcT6z6QfLdpH1H4ZHWcbODxAuZMwncCTLSkWLh0qlwJBY/Yqj4l+FmOrdwcB
         x6wxwb1o63gHxmIBPGDLG4yPiZ7nM9ZgRPUH/yMpWv5zglL6hFniO2GLls5cNlf+5oqy
         V+EU/AMLiVwykdrJgYLVWG5PJh/CNjAoT8RJXjbRWjJmJZvPGx2WU9i/1pITCPyl+od1
         EihHrB7F17JCEKoCnPEvIYkn91xcCoKxbXTu8DGstVjVqSI3fKO4fLkkErV9cIhkL2pu
         l2JGbNslo/vnIvtpbuGI5nR8Y7Fd4O2RhLbxJUin8/4HGYlqeDfNTbQF3m3o4LCWJXKz
         nUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703569010; x=1704173810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt8Y6H9UYhlcK+Kq+g9t/n5C3ulwRlQUCahaLJRULwM=;
        b=Qyh/Ivrd3FGAspw+HeCbiCMkc5WN2T+5iv5wgb6OmxMwQJSC3cLlKADCwxyH+ofEhS
         sqOsQp3Z6FFCPN8X40ejbxGDW0jRMX7ENXko0KiAvYfpr8/gjQ6ezxyvGT2Nykh4cTSH
         8eA7phLFhtI0V09Kcs9WIikyGvwepzMjH74W0hCipgQcfckiFBDC5RD80BTpMXQcOBhQ
         3L3kqOUvIR29fmMQYYbVKINX3CwCYW3gK1jGnHoDjo0jLIM0heTIbSR0U9we8mSZkbWg
         Ceu+g/t4ZK/gkNZdmLIMlJ2lR1NdS4hJAsnMEQLcWwmWMqBG0HFXkqC4yL8CLp2KdWgZ
         jEfg==
X-Gm-Message-State: AOJu0YzioY/0B7B+jZ/8GAk86nUw4viOmsoJDhsc+qx2PQAL9UuqSHlY
	nOa69gQpa4caCwbVBLM0KSp0+OVn+FFlsg==
X-Google-Smtp-Source: AGHT+IEWpDU3OhwCcS4KqMR5BEt9i18xozZDMVXrBdzYqH1/mZXMMZY7yPJGFUrViMSlAQI50dwQjw==
X-Received: by 2002:a05:6a00:181e:b0:6d9:ba7f:8b02 with SMTP id y30-20020a056a00181e00b006d9ba7f8b02mr3323033pfa.32.1703569009897;
        Mon, 25 Dec 2023 21:36:49 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id ff21-20020a056a002f5500b006cef5c09ca3sm9165969pfb.147.2023.12.25.21.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 21:36:49 -0800 (PST)
Date: Tue, 26 Dec 2023 11:06:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 3/3] riscv: dts: allwinner: Fill in OPPs
Message-ID: <20231226053647.kvrpn4pjtc2lhfcm@vireshk-i7>
References: <20231222111407.104270-1-fusibrandon13@gmail.com>
 <20231222111407.104270-4-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222111407.104270-4-fusibrandon13@gmail.com>

On 22-12-23, 12:14, Brandon Cheo Fusi wrote:
> Specify two voltage ranges, in order of increasing stability,
> for each OPP.
> 
> Also define an nvmem cpu speed grade cell of length 2.
> 
> Link: https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L133
> Link: https://github.com/mangopi-sbc/tina-linux-5.4/blob/0d4903ebd9d2194ad914686d5b0fc1ddacf11a9d/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L182
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6c..7e2e015e0 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -39,16 +39,23 @@ cpu0_intc: interrupt-controller {
>  	};
>  
>  	opp_table_cpu: opp-table-cpu {
> -		compatible = "operating-points-v2";
> +		compatible = "allwinner,sun20i-d1-operating-points";
> +		nvmem-cells = <&cpu_speed_grade>;
> +		nvmem-cell-names = "speed";
> +		opp-shared;
>  
>  		opp-408000000 {
>  			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt = <900000 900000 1100000>;
> +
> +			opp-microvolt-speed0 = <950000 950000 1100000>;
> +			opp-microvolt-speed1 = <900000 900000 1100000>;
>  		};
>  
>  		opp-1080000000 {
>  			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <900000 900000 1100000>;
> +
> +			opp-microvolt-speed0 = <1100000>;

I was expecting the above two lines to have same values. Why change
them ?

> +			opp-microvolt-speed1 = <950000 950000 1100000>;
>  		};
>  	};
>  
> @@ -115,3 +122,9 @@ pmu {
>  			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
>  	};
>  };
> +
> +&sid {
> +	cpu_speed_grade: cpu-speed-grade@0 {
> +		reg = <0x00 0x2>;
> +	};
> +};
> -- 
> 2.30.2

-- 
viresh

