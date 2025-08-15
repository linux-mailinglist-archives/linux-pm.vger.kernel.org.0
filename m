Return-Path: <linux-pm+bounces-32433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068E9B2806D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE651176FA5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EEE3019CB;
	Fri, 15 Aug 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsJ6eKPR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACF29A9CD;
	Fri, 15 Aug 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263521; cv=none; b=KO9sbbJDj2ea5v3/PY6p77U2eBN1kiSk0gIvyLOcVnDBSTazvs1fF0OKTMNV3E6qLf+jgdVUua8UilkpZrYXQNUoN+atKyUfL5b624NzV51KWTbj1SsYLaG6JiPd2yXv+z0839DtkCwIbEQ8uext+XArsi0Zhv0FUAxug8pO2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263521; c=relaxed/simple;
	bh=3PT0FaEFFRXzl7krjYoQ/az6uVdLOVRiq9kGOp1m92E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxxxzXV8FayjBI9fAfPGd5qMm6Rk3Isgpv3LAGaUXwKlTLHOQWpwIY2Vpb7zB9zXUPDAsYHzL98EEQKz6ZFsh70rngtRK8zdVHRMRoG214VWLkv1H9pgRb4WEgk/aRSEhp6zHI5h9RtCJdbKtQ9gHSpwFbk2CvPXcSJlxBA01p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsJ6eKPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0095C4CEF5;
	Fri, 15 Aug 2025 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755263520;
	bh=3PT0FaEFFRXzl7krjYoQ/az6uVdLOVRiq9kGOp1m92E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DsJ6eKPR7nuHTmi3gMb5Z+KofX4IrISgDCgSDQHJVxI3cEnqCbNDx9tmHfBMVb42h
	 G2UHMBnI8vdQ2ss1sUySb3hWZJ2wWGx4+h2taoK167t4w5MZmEk4fVpvu0X0ja7rPg
	 GukXhK+LQ1w24KcNy1lCD4S7z61QP/qTjj8X6rB1yeG1K4+is9cV/sFSdy4uVVxhQq
	 8digHqa1H4Bh6EEuZynoPiJGjuwxvp3Kufd7/HG2DQT1D7pig8L5lC848Gbx43gtdt
	 iXp7heSna3cc8KmLIHdnUr0QNjKM3Dzc+atxkSrsI0Lsdse9yqS0ayjsqgiPGA2j9Z
	 GsI2F1CyT2ROw==
Message-ID: <04e09739-2462-4a4d-8378-6c6514dca752@kernel.org>
Date: Fri, 15 Aug 2025 16:11:53 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
 <857f56a9-0fe7-4c10-a55d-b00740a8be02@oss.qualcomm.com>
 <7c96f881-23ae-484c-82b8-d388a5c637ca@oss.qualcomm.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <7c96f881-23ae-484c-82b8-d388a5c637ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 8:45 AM, Odelu Kukatla wrote:
> 
> 
> On 8/12/2025 3:21 PM, Konrad Dybcio wrote:
>> On 8/8/25 4:03 PM, Odelu Kukatla wrote:
>>> Add register addresses and clocks which need to be enabled for
>>> configuring QoS on sa8775p SoC.
>>>
>>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +		system_noc: interconnect@01680000 {
>>
>> stray leading zero
>>
> Thanks for the review, i will address this in next revision.> I also see there's a camera noc.. are these controlled internally
>> by Titan nowadays?
>>
> Yes, camera NoC is controlled internally.
By internally, do you mean that it's controlled by some camera driver? Why the camnoc is not using 
the interconnect framework?

Thanks,
Georgi

