Return-Path: <linux-pm+bounces-35447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C058BBA335F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 11:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D3344E1C4A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6527781E;
	Fri, 26 Sep 2025 09:45:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5B26C3AE;
	Fri, 26 Sep 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879953; cv=none; b=ol251s4bFqcn0Jegmf1JjF/fXG0MYFexpcFHk3EX6NXfxAHMaO1HEwWLE8WaYp1bgVywfOMs7teHM8irILTqdm7R1uvRLwl0EV3IJlaos9Y/nd6+JBtem3NA5wM1/LjrneQArfhw22vUHi0DCjpkrNq2X3Nc73JXv4FSg70tvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879953; c=relaxed/simple;
	bh=W6dmbj3nQuaOh1PvpWfrOaUzQV1DSYuduBdMkyJok1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUkIXxDboqKL0nZq7kP0EkKVwZ9zkUCVVTjzrvAyMjmqy4/uM6s5jLYsD2Je7NjhNsj4qDdyabcMXP989WAI0d83uddWGsfS4/qSqtxvd+LDaeWZvcWr9J2B1/SS3pFmDSbgwp6SrMGQy/nrTfh8QtmH4CfOMAyZ4k2R65jmhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8dac07389abd11f08b9f7d2eb6caa7cf-20250926
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8877f317-ac53-4448-93d3-6e10cc58c33d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:186bffe941cd4aec285e7a474c697022,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8dac07389abd11f08b9f7d2eb6caa7cf-20250926
X-User: zhangzihuan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1705799856; Fri, 26 Sep 2025 17:45:36 +0800
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	viresh.kumar@linaro.org,
	zhangzihuan@kylinos.cn,
	zhenglifeng1@huawei.com
Subject: Re: [Question] About unnecessary policy_has_boost_freq() calls in freq_table.c
Date: Fri, 26 Sep 2025 17:45:33 +0800
Message-Id: <20250926094533.542873-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0hshbbbTncpkZoS98jq+ChiARSZCNn5P8kaEduADbmHSw@mail.gmail.com>
References: <CAJZ5v0hshbbbTncpkZoS98jq+ChiARSZCNn5P8kaEduADbmHSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> First off, setting policy->boost_supported doesn't really belong to
> cpufreq_table_validate_and_sort(), so the idea of splitting it off
> that function sounds reasonable to me.
> 

Agreed.

> However, cpufreq_boost_set_sw() is used as a .set_boost() callback, so
> it gets called every time the "boost enabled" setting is changed.  It
> doesn't look like a good place for updating policy->boost_supported to
> me.

Got it, where would you suggest updating policy->boost_supported instead?

Thanks!


