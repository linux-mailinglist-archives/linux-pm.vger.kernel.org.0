Return-Path: <linux-pm+bounces-43922-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEDYA5c0rmkuAgIAu9opvQ
	(envelope-from <linux-pm+bounces-43922-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 03:46:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2582335C0
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 03:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FA4301B93B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 02:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D42010EE;
	Mon,  9 Mar 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EXmgdsAa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26756217659;
	Mon,  9 Mar 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024382; cv=none; b=Y9F8PR9e1a9NX/QDGS3zkdAKU1oy5VreL29uP3gB1nxBh4rCiXVkfN5ow/LFnYYc5nO3w0SoAvpiRRg289Id2ajX+KT3NIr2m6a/HjdmyxNhjtm6MpLw5jS44sfmWWYqFzbGxXrncdSCH/0B1T/bSs5hGGEwbIUilo91yU894tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024382; c=relaxed/simple;
	bh=o+ARsR8chCtiW/jAcIZoAmTru8DDd/CefzS85Y9zhrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LshqyCjdSGd+5XBxfSOwS3rb5crPZ7xsV5/d1bFg0NQqYpWHSgbm27yqP8sNCeBIKaTb/BlXa235AVHkMFfMLb3YTwLt9VJyOELrl2c0zaCGWI32Qzg7kX/jUmrK5Yl8boTOiP8NPB7hSgp+7UfkBShvXRN3YbW73qkqrGf+vIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EXmgdsAa; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fThGT6SsVz9tYN;
	Mon,  9 Mar 2026 03:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1773024370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1BjM0rf2n3gTAxYcEyrznxi8WA9wRDhAUvOuuf5WIM=;
	b=EXmgdsAajz8XB2ziZCvpNjOlSNjG0zxQUN48lyeA/eoR6QGJzpXx5qV5AL2SN7wolcquBj
	3kPK1BCdzmDv8ANZ7JKlG9ZIgK9A7env/8uoGypAiNN2RpSDjHfDxH4liEDKmc4I9L6jfm
	H8DNsIe2knW8NQzbG/rogB43MCvGYj7pEbM/jo+D0rpJR5F0ix/vkxNwy/18xyIksRTVc/
	r0R+FhwpIdBQOrFZqbrAB33cS7nnwcRw3tC33ZPJYSDUqH1T0aD0PjT5pas60TLxN6NSmD
	2GmEX+fOUnyyYDcl8eDYJ/C9aik+tk/K5G+rXKRC41OUhvJCMsQfs/bm6qKBow==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 10:45:49 +0800
Message-Id: <DGXWODJ8CGUN.KZFJ9JDJMEM3@mailbox.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <devicetree@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Yixun Lan" <dlan@gentoo.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Samuel Holland" <samuel.holland@sifive.com>
References: <20260308-shadow-deps-v1-0-0ceb5c7c07eb@mailbox.org>
 <20260308-shadow-deps-v1-2-0ceb5c7c07eb@mailbox.org>
 <610da0d3-1dc0-4f4f-afb4-869d3ed81321@sifive.com>
In-Reply-To: <610da0d3-1dc0-4f4f-afb4-869d3ed81321@sifive.com>
X-MBO-RS-ID: 4718965d707e9392835
X-MBO-RS-META: w3n6rf7qzhqwy6xkdx5zhxepjgn57kz8
X-Rspamd-Queue-Id: 7D2582335C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43922-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuwei.wu@mailbox.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.950];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Samuel,

On Mon Mar 9, 2026 at 1:59 AM CST, Samuel Holland wrote:
> Hi Shuwei,
>
> On 2026-03-07 11:17 PM, Shuwei Wu wrote:
>> Add Operating Performance Points (OPP) tables and CPU clock properties
>> for the two clusters in the SpacemiT K1 SoC.
>>=20
>> Also assign the CPU power supply (cpu-supply) for the Banana Pi BPI-F3
>> board to fully enable CPU DVFS.
>>=20
>> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 34 +++++++++-
>>  arch/riscv/boot/dts/spacemit/k1.dtsi            | 86 ++++++++++++++++++=
+++++++
>>  2 files changed, 119 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/risc=
v/boot/dts/spacemit/k1-bananapi-f3.dts
>> index 444c3b1e6f44..b87bf9d51cb1 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> @@ -86,6 +86,38 @@ &combo_phy {
>>  	status =3D "okay";
>>  };
>> =20
>> +&cpu_0 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_1 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_2 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_3 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_4 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_5 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_6 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_7 {
>> +	cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>>  &emmc {
>>  	bus-width =3D <8>;
>>  	mmc-hs400-1_8v;
>> @@ -201,7 +233,7 @@ pmic@41 {
>>  		dldoin2-supply =3D <&buck5>;
>> =20
>>  		regulators {
>> -			buck1 {
>> +			buck1_3v45: buck1 {
>>  				regulator-min-microvolt =3D <500000>;
>>  				regulator-max-microvolt =3D <3450000>;
>>  				regulator-ramp-delay =3D <5000>;
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/=
spacemit/k1.dtsi
>> index 529ec68e9c23..5c7bb5d85fc0 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -54,6 +54,8 @@ cpu_0: cpu@0 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <0>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
>> +			operating-points-v2 =3D <&cluster0_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -84,6 +86,8 @@ cpu_1: cpu@1 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <1>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
>> +			operating-points-v2 =3D <&cluster0_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -114,6 +118,8 @@ cpu_2: cpu@2 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <2>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
>> +			operating-points-v2 =3D <&cluster0_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -144,6 +150,8 @@ cpu_3: cpu@3 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <3>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
>> +			operating-points-v2 =3D <&cluster0_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -174,6 +182,8 @@ cpu_4: cpu@4 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <4>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C1_CORE>;
>> +			operating-points-v2 =3D <&cluster1_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -204,6 +214,8 @@ cpu_5: cpu@5 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <5>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C1_CORE>;
>> +			operating-points-v2 =3D <&cluster1_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -234,6 +246,8 @@ cpu_6: cpu@6 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <6>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C1_CORE>;
>> +			operating-points-v2 =3D <&cluster1_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -264,6 +278,8 @@ cpu_7: cpu@7 {
>>  			compatible =3D "spacemit,x60", "riscv";
>>  			device_type =3D "cpu";
>>  			reg =3D <7>;
>> +			clocks =3D <&syscon_apmu CLK_CPU_C1_CORE>;
>> +			operating-points-v2 =3D <&cluster1_opp_table>;
>>  			riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr=
_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
>>  			riscv,isa-base =3D "rv64i";
>>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "b", "v", "zi=
cbom",
>> @@ -339,6 +355,76 @@ osc_32k: clock-32k {
>>  		};
>>  	};
>> =20
>> +	cluster0_opp_table: opp-table-cluster0 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-614400000 {
>> +			opp-hz =3D /bits/ 64 <614400000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-819000000 {
>> +			opp-hz =3D /bits/ 64 <819000000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-1000000000 {
>> +			opp-hz =3D /bits/ 64 <1000000000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-1228800000 {
>> +			opp-hz =3D /bits/ 64 <1228800000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-1600000000 {
>> +			opp-hz =3D /bits/ 64 <1600000000>;
>> +			opp-microvolt =3D <1050000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +	};
>> +
>> +	cluster1_opp_table: opp-table-cluster1 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-614400000 {
>> +			opp-hz =3D /bits/ 64 <614400000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-819000000 {
>> +			opp-hz =3D /bits/ 64 <819000000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-1000000000 {
>> +			opp-hz =3D /bits/ 64 <1000000000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-1228800000 {
>> +			opp-hz =3D /bits/ 64 <1228800000>;
>> +			opp-microvolt =3D <950000>;
>> +			clock-latency-ns =3D <200000>;
>> +		};
>> +
>> +		opp-1600000000 {
>> +			opp-hz =3D /bits/ 64 <1600000000>;
>> +			opp-microvolt =3D <1050000>;
>> +			clock-latency-ns =3D <200000>;
>
> What is the initial voltage set by firmware before Linux boots? If it is =
1.05V,
> this is fine, but if the default is 950mV, then you cannot enable the OPP=
 table
> in the SoC .dtsi file. Boards other than the BananaPi F3 are missing the
> cpu-supply property, so they won't raise the CPU voltage before switching=
 to the
> higher frequency. The usual solution is to put the OPP table (or at least=
 the
> OPPs that require a higher voltage) in a separate .dtsi file, and only in=
clude
> that file from boards that provide the cpu-supply.
>
> Regards,
> Samuel

Thanks for the suggestion!
I confirmed the firmware sets the initial voltage to 1.05V at the default b=
oot
frequency before any scaling occurs:

~ # cat /sys/class/regulator/regulator.4/name
buck1
~ # cat /sys/class/regulator/regulator.4/microvolts
1050000

But I agree that moving the OPP tables to a separate .dtsi is a much safer
and more robust approach for boards without cpu-supply.
I will implement this in v2.

Best regards,
--=20
Shuwei Wu

