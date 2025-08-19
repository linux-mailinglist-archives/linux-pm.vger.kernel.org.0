Return-Path: <linux-pm+bounces-32644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA557B2C608
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925F17BC02F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6778342CB5;
	Tue, 19 Aug 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7bCTQ01"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB519C540;
	Tue, 19 Aug 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611180; cv=none; b=h3IArJMdhIKXIG2kHTibij6NaEt4+HhybHN/3WQ4tevuAobewxXrRQI7OpzjSgD16idXOXyLUGXffSs/+eh4SNa0zzb9KRPsK6QDiKV0M8kD0EKpa4pgUi1r6N04S8o7HAPN77vIN5InKOMeya4DMa22g8scaQoDB35XWLnzm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611180; c=relaxed/simple;
	bh=SAIdtJM6LkCatVrWImthiJwziRX8HOwPKgj2HFdZhvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj1p/F/xWpo3aC1OoddmfrIJTOuI3QLCF0UHygGURT/GhQHOIwQidZ5SNrSfiHsJA1BX8mPyLHlddHp8aBWAfA0RiRENfZudImcrJCfjMiPyQd5ZZNifUlIGeR2CAZc4Zm8RH306FxZ00qra1PR8cIB3nNq+WSKqShFG9TptD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7bCTQ01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9184AC4CEF1;
	Tue, 19 Aug 2025 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611179;
	bh=SAIdtJM6LkCatVrWImthiJwziRX8HOwPKgj2HFdZhvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G7bCTQ01ocGyuf7Ag+FCzBiLcGF6hKZ9fBvQ95He86f9Ej3Ldx/mgauUKUiISjqj2
	 9EgrHA6nTshi3eIugwWGB0bg1SMI+fD7o63r71gVBBOs+meW9RQ72IxBnWqiqugCaE
	 CdnV0ELf5EXNhTg+tVYAoNVuVSnjY9hMtKUXkjMXYd5U1NrWSRWawQQKpiUNyOAKyw
	 w7q3VeRbiiuAnSHFVAbnq42Sb/nB+0lFs9oSlc92rj5hVTnJ34cmUBlPdmuM3O1yVh
	 qQ7Kvn3TM+gInzVx4k7siRktKIjKpFehW+AfW2HvhQwKzxST7ojgeWKv9JX1OJOiUW
	 gm340Ack5NBDQ==
Message-ID: <363db534-92a2-4108-8a41-8e07ec22513d@kernel.org>
Date: Tue, 19 Aug 2025 16:46:13 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
To: Rob Herring <robh@kernel.org>,
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
 <CAL_JsqL+C1VueQjrKra8fNTd-2k=gkoy-jA9uuQOhuyRMbQroQ@mail.gmail.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <CAL_JsqL+C1VueQjrKra8fNTd-2k=gkoy-jA9uuQOhuyRMbQroQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 4:31 PM, Rob Herring wrote:
> On Thu, Aug 14, 2025 at 9:54 AM Raviteja Laggyshetty
> <raviteja.laggyshetty@oss.qualcomm.com> wrote:
>>
>> Document the RPMh Network-On-Chip Interconnect in Glymur platform.
>>
>> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
>>   .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 172 +++++++++++++++++
>>   .../dt-bindings/interconnect/qcom,glymur-rpmh.h    | 205 +++++++++++++++++++++
>>   2 files changed, 377 insertions(+)
> 
> This is breaking linux-next "make dt_binding_check". Looks like the
> clock header dependency in the example is not applied. Please drop
> this until the dependency is there.

Thanks! And now i see why my script didn't catch this... now fixed and
patch dropped.

BR,
Georgi

