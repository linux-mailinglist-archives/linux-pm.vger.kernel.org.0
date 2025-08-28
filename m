Return-Path: <linux-pm+bounces-33324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A5B3A9EA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA757B53FD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87BD270576;
	Thu, 28 Aug 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="S7qHI2te"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726A26F2AA;
	Thu, 28 Aug 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405476; cv=none; b=m/lJaqvvJL4UT9SkCnCuBKP7GTdTZjDpfJQGJ/qSOzGOBgg4kURW3q+3LJwsLnezsdFUhJgbFKGTIn0KjAxD+uUGS9PGkSzkfiAX48pqqKJB3Y1n1aXpf6VMHY2wTaUAz/yVX5SusVUbGlEy8XMDCzJAbi8DgdkPO+rSAAtUGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405476; c=relaxed/simple;
	bh=BVWDKl/Txzg+8cWcQfv6ZmaGlIRf9Zu4/imEGCNcqOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tylqn9QSep/EZCf+eOropzjsvfPuDXDuQFLlSUIXJoVXo0+/zajggGasRVBVG6LceVDs35hFNFHWlu0GUIfIksCy3ube0jxtSwu2ihS341E1uGAPWSsyddzbGgfxbxiqP7DnhmeEFu1Dxduoxwq1Ej4p9sIPXUxMceNgAKpJzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=S7qHI2te; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bwUo0fKp9KHZFc4bG4aZ9xW+sQsK/q/ntwGNTng5Tbg=; b=S7qHI2teJrClJfLOvmxKpLyWiq
	BC7XAsDpBy37dLqava6RktRieoWxQx/IgDMt2cVrhBJ5CT1HMMnjF5i3OUP2w/XmULaObwBZgSF+t
	Eb4SCaO0xQsItXr/cmBDgpAXUKvluSNn0VXEz2GvlCtreHUgfGvJz0Ps+TPe+6WCsjA3LAivCM2bb
	zLhVyPBxgV5Lm1PO1cLfgAE5gamJocp+1V7eMcuiajYIv6Y/NIOqTsWtNjPzelEHjzjX3ax+A9f7q
	UTxBToG5RzqEClxUAzwKTKu731Q43SQuc5sL2G1DpUdz88m5TxMAnaLlFH410pbQJCfKTKC4FaOZ8
	nPZq/Acw==;
Date: Thu, 28 Aug 2025 20:24:21 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Jerry Lv <Jerry.Lv@axis.com>, Pali
 =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 stable@vger.kernel.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 0/2] power: supply: bq27xxx: bug fixes
Message-ID: <20250828202421.57bbbd2c@akair>
In-Reply-To: <cover.1755945297.git.hns@goldelico.com>
References: <cover.1755945297.git.hns@goldelico.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Sat, 23 Aug 2025 12:34:55 +0200
schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:

> PATCH V2 2025-08-23 12:33:18:
> Changes:
> * improved commit description of main fix
> * new patch: adds a restriction of historical no-battery-detection logic to the bq27000 chip
> 
> PATCH V1 2025-07-21 14:46:09:
> 
> 
> H. Nikolaus Schaller (2):
>   power: supply: bq27xxx: fix error return in case of no bq27000 hdq
>     battery
>   power: supply: bq27xxx: restrict no-battery detection to bq27000
> 
hmm, is the order correct? To me to be bisectable, should it be turned
around? Maybe Sebastian just can do that while picking it.

Regards,
Andreas 

