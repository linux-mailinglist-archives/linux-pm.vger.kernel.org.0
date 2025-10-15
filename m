Return-Path: <linux-pm+bounces-36188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EBDBDED6E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD833A71AA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206224BBEC;
	Wed, 15 Oct 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdqfJU7d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC11231836;
	Wed, 15 Oct 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536188; cv=none; b=gc4KYN+gxtKgqmbyqtjg46FtViIrk8a/f7wfssv7U+N01ewo1SascgU4DX9RAwo3i2Moa6dbVD25lQL3y7/paomMA4BCav3Cn7f1o6P14kDM+Mi76dm3Iq6ochUHdSpDGLspTXvRFa1Uvh0Fow5P6mVRBKGFFn5MSjXslOXQiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536188; c=relaxed/simple;
	bh=SHSdSGM4L947VuTmWiJYNKTD/YrVIY8PXjfmcpTLgh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZcPgyaT2V6H3iV7tBNEmfbwlOGcHi1Mo+Aq5J9sF8NN5rzUmcb2rmTCtgWH66QMqDj6zFOGU4+wywsjiTEz26TY5PUWodQi+Aq59rwWmJic7xCtr4PuKNsy84nEQVo246UifAa2RsQv0AUwrMVlqumo9DyHs0sg45dBO+UUctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdqfJU7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1999C4CEFB;
	Wed, 15 Oct 2025 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536188;
	bh=SHSdSGM4L947VuTmWiJYNKTD/YrVIY8PXjfmcpTLgh4=;
	h=From:To:Cc:Subject:Date:From;
	b=GdqfJU7dHN8It4JAHaMg9qnSkgMVo8FGSbBGiR/y4XcvOqmiCYsfBjoNfeflVu/FU
	 9gavpnmLEN3lxgxKkx1b6ij2dDBcAxSsYdfoNZleHhveSBv/e9nqsq//ynZVT8aZK1
	 ZG6kiwERTGETknidpAqyKNn/NCTYQQvEsdp0ChpRnuw63C5mRrYcw7Xynz/n56QS61
	 ac8sfdiKTyZ+eFiWLQ/Er+kBrcr5OdzEEhKKc4sCMTN24AWzgeFkaL+gOfLudXN2QC
	 FyA2rWToskmfDzRXmYdMfK0JyZASvRXSQmM4nexwtaISrQ4x/LoSI4VOxLuaDUkkKi
	 cE7p5THKQqNnA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject:
 [PATCH v2 0/3] cpufreq: intel_pstate: Adjust the energy model for hybrid
 systems
Date: Wed, 15 Oct 2025 15:45:28 +0200
Message-ID: <2404176.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

This supersedes

https://lore.kernel.org/linux-pm/5937608.DvuYhMxLoT@rafael.j.wysocki/

because the last patch in it resulted from some confusion.  Sorry about that.

In this series patch [3/3] simply switches over the energy model callbacks to
using CPU types retrieved from CPUID instead of scaling factors which is more
robust and allows the energy model to be tuned more precisely.  In particular,
it will now allow P-cores to be populated when E-cores are utilized above 60%
of their capacity (and not just in the "overutilized" situation or when there
is a task whose utilization exceeds the E-core capacity).

The first two patches in the series are preliminary.

Thanks!




