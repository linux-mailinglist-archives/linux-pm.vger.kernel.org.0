Return-Path: <linux-pm+bounces-28426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB90AD4866
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 04:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAD188E921
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8B1714AC;
	Wed, 11 Jun 2025 02:11:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC3188A0E;
	Wed, 11 Jun 2025 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749607870; cv=none; b=ua8m4UvGEky5QdLVSmGPsNTrDD32Wi0kcrF7RRN6NTv7xuzqK5OyW34e6PoYUyqNoOO75My2N1SVKDnK+boMPUslIiMDCDm9q8y9bigI1EdbScOfNZDo2kKMk6zB+9qlQADZNTtaUW7HMDrVVbsqom01/Xnq9OkMhvjKJMty8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749607870; c=relaxed/simple;
	bh=V5UN5NhiNun71JzA8xAksH+w0p9JSGOBeaRrap2XsUI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=BDNfhOQqNiZRNa+oUkqqT6EZUj5oCTRJq8q2IrC6lOHgceWoxBhpazvRFaO/Vldhyp9spyouvKj/pD8R0vGUCw64I0HGF6BrC1/lQHzVQg+sTs2AeHq++DUXH0Sqj2lgadXtnYbvtHKR1muXNE16HOz11gaDibfBg4sUoGoBnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bH8K31lSsz5B1Gv;
	Wed, 11 Jun 2025 10:11:03 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 55B2AotE031617;
	Wed, 11 Jun 2025 10:10:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Jun 2025 10:10:52 +0800 (CST)
Date: Wed, 11 Jun 2025 10:10:52 +0800 (CST)
X-Zmail-TransId: 2af96848e5ac313-fd045
X-Mailer: Zmail v1.0
Message-ID: <202506111010521118VJaiO_pb0rD7b3daxqox@zte.com.cn>
In-Reply-To: <6b9d5edf-7186-4d7b-814c-5c3f306c68db@kernel.org>
References: 20250610193403161UQCV5cVGXCRVDheTb7jvi@zte.com.cn,6b9d5edf-7186-4d7b-814c-5c3f306c68db@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <krzk@kernel.org>
Cc: <ulf.hansson@linaro.org>, <changhuang.liang@starfivetech.com>,
        <geert+renesas@glider.be>, <magnus.damm@gmail.com>, <heiko@sntech.de>,
        <alim.akhtar@samsung.com>, <walker.chen@starfivetech.com>,
        <sebastian.reichel@collabora.com>, <detlev.casanova@collabora.com>,
        <finley.xiao@rock-chips.com>, <shawn.lin@rock-chips.com>,
        <pgwipeout@gmail.com>, <qiu.yutan@zte.com.cn>,
        <linux-pm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gcG1kb21haW46IFVzZSBzdHJfZW5hYmxlX2Rpc2FibGUtbGlrZSBoZWxwZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 55B2AotE031617
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6848E5B7.000/4bH8K31lSsz5B1Gv

>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>> 
>> Replace ternary (condition ? "enable" : "disable") syntax and ternary
>> (condition ? "on" : "off") syntax with helpers from
>> string_choices.h because:
>> 1. Simple function call with one argument is easier to read.  Ternary
>>    operator has three arguments and with wrapping might lead to quite
>>    long code.
>> 2. Is slightly shorter thus also easier to read.
>> 3. It brings uniformity in the text - same string.
>> 4. Allows deduping by the linker, which results in a smaller binary
>>    file.
>
>So you just taken everything from the same my patch - even entire commit
>subject and commit description - and sent it as yours?
>
>https://lore.kernel.org/all/20250114203547.1013010-1-krzysztof.kozlowski@linaro.org/
>
>oh my, if doing EXACTLY the same keep original authorship - the From and
>Sob fields.
>
>Best regards,
>Krzysztof
Dear Krzysztof,
Thank you for your suggestions. I have carefully read your advice and
made adjustments to the patches accordingly. I used your patch as a
reference standard, not just taking everything from the same your patch.

Based on your suggestion, I have consolidated the series of patches for
the pmdomain driver into a single patch. Additionally, following
@changhuang's suggestion, I have supplemented the patch for
drivers/pmdomain/starfive/jh71xx-pmu.c.

If there's anything inappropriate in this patch, I sincerely apologize.

Best regards,
Mingyin

