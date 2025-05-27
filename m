Return-Path: <linux-pm+bounces-27690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7F3AC5334
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 18:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA13317E97E
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415127C149;
	Tue, 27 May 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b="jCPrRhHs"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EADB2609F7
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364176; cv=none; b=tk0UfhnqS7/X7YdxNxgCmE1Lhdtdv3XEk0O3iDKA5q1mIX5HAcMpeElxZXHFVTW4qIx+a5bBf2QhUu8RYtxlyYRJj224SKQd+EBXxFm2C5jpYStX0AHem9u+gasIG7Xphu7uTCNzeoJyfK69mBIRJC6E5GD5t5YhyPAWg8rC2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364176; c=relaxed/simple;
	bh=ku/v7ji6DT3u6PEKUyFFkZRVwekFEnBZYNw8htFk6Ks=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=SgAzrhAa4TaxApDuwT/NajtiOgJ09CAZ0UsKJSROeqhf3jq4tcUSse7AGDKKpxRerQnqTogSvW3cIYcHRTq1q5MzF2pdBCE4n7fTLaxBryHhziV1thK3tuuWcG7Shi+q2lZr+/SMJbbtQf6VC5sBeu43DAQZMRB1+e/fwY9vwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com; spf=pass smtp.mailfrom=kuruczgy.com; dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b=jCPrRhHs; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuruczgy.com
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuruczgy.com;
	s=default; t=1748364170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku/v7ji6DT3u6PEKUyFFkZRVwekFEnBZYNw8htFk6Ks=;
	b=jCPrRhHsmM+bdPCaHZ4TMonT810h3vyJwzZx9QatnZzIqXa3eyerbghb7Z6Uab7rl/AgoJ
	SlCsFYRL0THSaorzI5ELgK3TuOOqmqxkYBa9LxyrxMa+8kWBDKyEPis9NR806Syi83nR7k
	saVh8NSj/CZDQMMuAcls44Fx6I8leVU=
Date: Tue, 27 May 2025 16:42:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: me@kuruczgy.com
Message-ID: <a6ed79b329492648a496353db1462e7a7a09597b@kuruczgy.com>
TLS-Required: No
Subject: Re: [PATCH 5/5] power: supply: qcom-battmgr: Add charge control
 support
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>, "Sebastian Reichel"
 <sre@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>
Cc: "Subbaraman Narayanamurthy" <subbaraman.narayanamurthy@oss.qualcomm.com>,
 "David Collins" <david.collins@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com
In-Reply-To: <1b1c4617-0e5b-40c8-9a66-d243b48c0977@oss.qualcomm.com>
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
 <20250523-qcom_battmgr_update-v1-5-2bb6d4e0a56e@oss.qualcomm.com>
 <db0e40b6-22f3-46aa-b35d-7a8729370ddf@kuruczgy.com>
 <1b1c4617-0e5b-40c8-9a66-d243b48c0977@oss.qualcomm.com>
X-Migadu-Flow: FLOW_OUT

> No, sc8280xp and x1e80100 don't support it. So I didn't add the support=
 for them.

Hm... From what I heard charge limiting works on some X1E laptops, e.g. t=
he ThinkPad T14s on Windows using Lenovo Vantage.

Do you happen to know how that works? Is that some vendor specific soluti=
on? Or does it depend on the version of the battery management firmware? =
(AFAIK this is part of the adsp firmware?)

Thanks,
Gy=C3=B6rgy

