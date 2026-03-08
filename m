Return-Path: <linux-pm+bounces-43918-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKvBESC5rWk+6gEAu9opvQ
	(envelope-from <linux-pm+bounces-43918-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 19:00:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D72317FC
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F6B301016E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E6393DD8;
	Sun,  8 Mar 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P6GBo6cl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5473313E15
	for <linux-pm@vger.kernel.org>; Sun,  8 Mar 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772992793; cv=none; b=Z6V7Qid2q80BcRcQIVhwI1a7FwnMGYHO2fJNL8WHpXm70IG4GNc8+UTxJClaFI2WesVDkV4GQVhSke4Q0+f4IfotH/Y99DRmvRD3gYA1zNqCFkA221Z6MmnqBw89ffN3TSvqZwCiy0DOF9k1egHwed1wmqDCQ3RTpah2RK4+5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772992793; c=relaxed/simple;
	bh=2w00/5rikfHMrMWNlIDnWCYd2a3uo7SKCGFo4KzYTnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1Jqk1CXGA+uZQIDPUScb+RfLDCSR19eChFmjYVC/6xearlUHVDViY5LKWZeQDokjK39l6zlCCi6s0pCMUqERv+4b61ViYvpFcofbbEnuhNglkV2KLDARQAz7j+HciOBgDjOE3j7VcTdd2TYv9JIE8+RtavgoW08bSySJkAMUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=P6GBo6cl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7985d11da10so108513547b3.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2026 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1772992790; x=1773597590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TV+fid+6EASBoKc0dODxReLnENoxtwD9DEo9QwziAPo=;
        b=P6GBo6clpxwiamftDGGxYGuu6HTLsqls+6wLA7IvKQRChNYickkaW3xCi5im16m/nY
         NFHs34iG0RXBLAK0ootF775h96p8udK56b7jPfsf+dqIu4xc16KiqhtgJGg+GvhUAux1
         kCl7J1h9oKidXVooI9E7NjhMQVisQaoqB04HcHSkzqCrq3ln4SDziaooeHVuNlJxPieY
         /1CwOP1IJEk/PwHeDOuwVxjaHRhZ0F+1qYq0xyJ9A+fEMkDl3aDYMVsm8TsZnVHKvA1d
         za4VtwlkIKETBBAb+22Tr55QRNnSL+SHhBjan7d6JGIhb9seZ9VKduuS1BwNZk1UT6J5
         NA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772992790; x=1773597590;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV+fid+6EASBoKc0dODxReLnENoxtwD9DEo9QwziAPo=;
        b=B/nR6+qEhbVQ+txV4Q7+/D/g2jVLddS9bGsExhMlpZsxcc/OOit/zJODkfxBcfEHOA
         9+mGbsdp3ZXsFfb9BhzkKraxOLE8nOlzRcEEjHVvd6TnhScDO32DvTHtKqzLWR5SSP5B
         udDi2kGE2OeJ5RdZhh83sWr0JTcVbdQwJy/Hcaw030ieK2gdcWRgYQgQ9uaRsCITBYJy
         zxCeFp6z3pV6ac16Bfkq3TeyJUS/ervfjXMFRUt6j/6IJRqIZYrKKpxIZS/iRoEvxW3I
         E3opGoTKC9d9Lgf8EaCfS0cC9JPxUVV8qx0VOjlfQmg9t8x1mXRrtTZkH32gwK89kGUX
         G06g==
X-Gm-Message-State: AOJu0YzpFhXV5bUUCk+5ULxaf+qmCTllR1xhY/5QeKmWBoIgYxjLZxfV
	KEPu6lDB8rSI0cMXWh/7C4cuqLDYaMpOYE5MhOgRird+PU1ZPNIA0KjYR67atbkoQ4o=
X-Gm-Gg: ATEYQzxgcwylYxcUeNs6ITCcLCT8sKnsELPS9Z5L2W4EVGkBmYubp9jMSrXxwvxfpeF
	E+ohJRaSkiwYR53ZkyvwCmgq1EDkzwA0q3XeoCRa0DOXJ9f+VX30kUghkux3zJtIOH8yeZR7BpS
	J3oYZBrh4oyI0EapFPq0GeRzrIP6yDvcF6JVw32xBcAkr0djdYvfiV082YOj/nFKlwR9O7H45yb
	QVEIKjwNJGZQZvXuoGcIWDkXE/tlZ8Dws9QIfxcqpDix/ar4Jph8ubwSvip5yB3r4nupPN5vfQe
	s8Wkhnvh6von06v50oicuxezYzyWgBQ0GKXnDB/WyKrpluw1hoCH4/Er+ZQsrGbFo/Q6kETy5Mz
	N3whWxSnLJicKAdJHy3t+hUNxNOugk3QPS+DsELWB0O+ATnuJlNDl18lqjUR9YUNwCa+J41NEQY
	3fqU7YKjzxPc7CHUcdu+ddnxg/233R/ZTYr5YvrUNfLdY7lIjf66s=
X-Received: by 2002:a05:690c:6b12:b0:797:ac4a:6ff8 with SMTP id 00721157ae682-798dd79737dmr77044737b3.61.1772992789901;
        Sun, 08 Mar 2026 10:59:49 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.33])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dec8b953sm34660587b3.6.2026.03.08.10.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 10:59:49 -0700 (PDT)
Message-ID: <610da0d3-1dc0-4f4f-afb4-869d3ed81321@sifive.com>
Date: Sun, 8 Mar 2026 12:59:48 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yixun Lan <dlan@gentoo.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org>
 <20260308-shadow-deps-v1-2-0ceb5c7c07eb@mailbox.org>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260308-shadow-deps-v1-2-0ceb5c7c07eb@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D06D72317FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43918-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.holland@sifive.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Shuwei,

On 2026-03-07 11:17 PM, Shuwei Wu wrote:
> Add Operating Performance Points (OPP) tables and CPU clock properties
> for the two clusters in the SpacemiT K1 SoC.
> 
> Also assign the CPU power supply (cpu-supply) for the Banana Pi BPI-F3
> board to fully enable CPU DVFS.
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 34 +++++++++-
>  arch/riscv/boot/dts/spacemit/k1.dtsi            | 86 +++++++++++++++++++++++++
>  2 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 444c3b1e6f44..b87bf9d51cb1 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -86,6 +86,38 @@ &combo_phy {
>  	status = "okay";
>  };
>  
> +&cpu_0 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_1 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_2 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_3 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_4 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_5 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_6 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
> +&cpu_7 {
> +	cpu-supply = <&buck1_3v45>;
> +};
> +
>  &emmc {
>  	bus-width = <8>;
>  	mmc-hs400-1_8v;
> @@ -201,7 +233,7 @@ pmic@41 {
>  		dldoin2-supply = <&buck5>;
>  
>  		regulators {
> -			buck1 {
> +			buck1_3v45: buck1 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3450000>;
>  				regulator-ramp-delay = <5000>;
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 529ec68e9c23..5c7bb5d85fc0 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -54,6 +54,8 @@ cpu_0: cpu@0 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -84,6 +86,8 @@ cpu_1: cpu@1 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -114,6 +118,8 @@ cpu_2: cpu@2 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <2>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -144,6 +150,8 @@ cpu_3: cpu@3 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <3>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -174,6 +182,8 @@ cpu_4: cpu@4 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <4>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
> +			operating-points-v2 = <&cluster1_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -204,6 +214,8 @@ cpu_5: cpu@5 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <5>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
> +			operating-points-v2 = <&cluster1_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -234,6 +246,8 @@ cpu_6: cpu@6 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <6>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
> +			operating-points-v2 = <&cluster1_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -264,6 +278,8 @@ cpu_7: cpu@7 {
>  			compatible = "spacemit,x60", "riscv";
>  			device_type = "cpu";
>  			reg = <7>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
> +			operating-points-v2 = <&cluster1_opp_table>;
>  			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>  			riscv,isa-base = "rv64i";
>  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -339,6 +355,76 @@ osc_32k: clock-32k {
>  		};
>  	};
>  
> +	cluster0_opp_table: opp-table-cluster0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-614400000 {
> +			opp-hz = /bits/ 64 <614400000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-819000000 {
> +			opp-hz = /bits/ 64 <819000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1228800000 {
> +			opp-hz = /bits/ 64 <1228800000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1600000000 {
> +			opp-hz = /bits/ 64 <1600000000>;
> +			opp-microvolt = <1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +
> +	cluster1_opp_table: opp-table-cluster1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-614400000 {
> +			opp-hz = /bits/ 64 <614400000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-819000000 {
> +			opp-hz = /bits/ 64 <819000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1228800000 {
> +			opp-hz = /bits/ 64 <1228800000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1600000000 {
> +			opp-hz = /bits/ 64 <1600000000>;
> +			opp-microvolt = <1050000>;
> +			clock-latency-ns = <200000>;

What is the initial voltage set by firmware before Linux boots? If it is 1.05V,
this is fine, but if the default is 950mV, then you cannot enable the OPP table
in the SoC .dtsi file. Boards other than the BananaPi F3 are missing the
cpu-supply property, so they won't raise the CPU voltage before switching to the
higher frequency. The usual solution is to put the OPP table (or at least the
OPPs that require a higher voltage) in a separate .dtsi file, and only include
that file from boards that provide the cpu-supply.

Regards,
Samuel


