Return-Path: <linux-pm+bounces-32345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C825FB25200
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330241AA699C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF31F5413;
	Wed, 13 Aug 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olN1s3XN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15732303C8B;
	Wed, 13 Aug 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105646; cv=none; b=HkrLKFU3uUPurt2cB17l62pK6samM8kvcYktqS+uma8krMoMQFNGhAo3K8d8DDSo+XIht3+Sdt8h0qlPKyb3pG072jpaVvOxtic/pdompPq7SkjXP/odZCPqhFOE2ILvKkRfP5nceydUF4+m8Xwrbyu4WicYTkgkCGKlDs9I078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105646; c=relaxed/simple;
	bh=kG4w34609CbeFYkvGA0oCxW67lmlVgrxwiJfEUKEBLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5tZXMIyUCSXdapucUeuDgEcHIRlv45fyIla00+TSnmVPOVhtKeqotckhQaeb09d3puuvY4zHrOni64ITjluF+IEqOxdT5qtgf2yeuH5+qjdySQBcRE/W033U2XUf6NTUQd55CATNRPZIJWOGEwG8EJh06YPYwP/9ui0WMpJRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olN1s3XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A60C4CEEB;
	Wed, 13 Aug 2025 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755105645;
	bh=kG4w34609CbeFYkvGA0oCxW67lmlVgrxwiJfEUKEBLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olN1s3XNLU+ezg97g945LYlO8HE9PzKAJWgyLI8T3jpzhtQIgeY60CkWDnyXlQZRD
	 YZ0Ag9Kit5lXfYeR/zg5L1YCb5YWqMdkS+Z6nuFHNvEFO/DyoAjNw2+c+oB7mIcVQG
	 PzIZeaPorCedmI79w1Xs8BCSoxbFEooINqe1hGzrpxW49VyHQ6y3k70wNfHlUdL9yX
	 nt6k1lP6omhyN1AQeHrdffK3GXQRZtbocCoF9tLBq7ODZ3XvODvei4dYNdZY14CYiC
	 dvrgmgGV1DrWNKrYSA3thfhMAx9Y/j+fkaNU5LVB84XYNv3Z+Oh2ZMBBdx7eG/hDf4
	 dJgOnHrEyQSQA==
Date: Wed, 13 Aug 2025 12:20:42 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Taniya Das <quic_tdas@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
Message-ID: <ii366w2aftbitlhlmsa5fhbcn4s2n2fc35plrrb5tlsmtv4udv@btbtgo2vr4tw>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
 <d56920b0-0bbb-4951-aa02-152da6b9f9d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d56920b0-0bbb-4951-aa02-152da6b9f9d2@oss.qualcomm.com>

On Tue, Aug 12, 2025 at 02:25:12PM +0530, Taniya Das wrote:
> 
> 
> On 8/12/2025 9:15 AM, Bjorn Andersson wrote:
> > On Wed, Jul 02, 2025 at 02:43:10PM +0530, Taniya Das wrote:
> >> Add support for video, camera, display and gpu clock controller nodes
> >> for QCS615 platform.
> >>
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> >> ---
> > 
> >   DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
> > /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
> >         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
> > /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: clocks: [[43, 0], [45, 2]] is too short
> >         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
> > /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: Unevaluated properties are not allowed ('clocks' was unexpected)
> >         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
> > /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: clocks: [[43, 0], [45, 29]] is too short
> >         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
> > /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: Unevaluated properties are not allowed ('clocks' was unexpected)
> >         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
> > 
> > 
> > The missing clock-names in clock-controller@100000 predates this series.
> > Sorry for merging broken patches in the past, please fix that as well.
> > 
> 
> Bjorn, would you prefer that I add the clock-names property to the GCC
> clock node to resolve the warning, or should I instead remove the
> required: clock-names entry from the qcom,qcs615-gcc.yaml schema?
> 

It seems to me that the qcs615 gcc binding and driver is lacking a
number of clock inputs. Can you please look into correcting this, and
based on that resolve the dtbs_check error?

Thanks,
Bjorn

> Let me know which approach aligns better with your expectations.
> 
> -- 
> Thanks,
> Taniya Das
> 

