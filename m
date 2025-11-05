Return-Path: <linux-pm+bounces-37436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53869C34E80
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F32BC348104
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C32FFDCA;
	Wed,  5 Nov 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="IYVrljAR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D52C0292;
	Wed,  5 Nov 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335653; cv=none; b=CZ1U/McMUqk+S0TNbvbfGPqsoOi6vZh/mYqiTC4y/7Q0W1FC54e6NM7iu+YNJFcitTKQVly8QRqE9FeYm5om24N04sluG1CjhbRYvUabvD5FdDKn/Dg4oxw90wPZUNzWPbX+CW2kQngkupyHPQqSo1OxpqiEm3pINL+TzI8las8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335653; c=relaxed/simple;
	bh=YDG6GlX2MFv5Jl8zJ04Myi8+16OhyFZtXtJ9om+gJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUyTNK4Lj8YZ75X3RL3v0rj1G3vi3/FoI2itWX2tRZr+TXrGlENZbOH4kgjNHmLehKIgLdz2GP3l+cuuKNAHFqsi7JIL5vWWYaUxhe4284In8KPdA/sS4UITwTdxTVidYXwEScS7pZubhbQbMZjojKqCCQfjcU0VCVvzqgsjz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=IYVrljAR; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762335632;
	bh=K9p96Az0vCcI2Emov1fVQ5bmu6QW46dlAQR5fZt//iA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=IYVrljAR8qNal8NFuc/xER3dc1nNOE3oMUf367rzpQX93lhOk2FF9yl72psSLv/we
	 My3LzdD4NktO0pfvKLd4+Vzwbq1iNSbRUKqisKG14YWVgwf38QjOFzCWK36wznkJsL
	 ct7IGkpKLJ2dQEPtdzUi7giCM9EmUstcMUXeP0gk=
X-QQ-mid: zesmtpgz6t1762335631t1e862f50
X-QQ-Originating-IP: T4f5BgaEKZsfrThhwXckLHTlcpww6njpPZICjjiO+ac=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 17:40:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7969792345943648528
EX-QQ-RecipientCnt: 14
Date: Wed, 5 Nov 2025 17:40:29 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Lee Jones <lee@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <315F0431BCF1D233+aQsbjbI6J9OAHTaI@kernel.org>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093544.GE8064@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105093544.GE8064@google.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NVrD5uPzBHuhDfB5axg6cP4CBe+kLgxMNSCXMGcDIEZgwGrtWFgnL4Tj
	tOziCmLnO5Ypw5Bs15iOODsaSmwCzOQYdIlh6PvvEt7P/T5Cn5nZnjvkhiKFOV5AddjlLgX
	4oWxxRVA+zWgZg5cavocfK0POBg7AAK7Q68vtc2nQX8o3ysDdENG64DwQS4eHnSrUozmI8X
	lLEOQf7hIXsR5HasV0sbpKZSN2eK4HNhCcJbW8Mwrxc3W9a/BcSR/Xhb5fDVeWjcSlO7dH1
	nVaqd2YIG8Zn1Qe5OaVC79Omw0/1oEZd8rGrGAbK1Bmrm/yribfhUiw84ut1NaJozJTGKW1
	WOvc1leXZE8e3ZA3zAfU+ejWGBu0OxCEzgBgHpQtKRBCYlhHYuTbl7rmtOdpO91109mvRCV
	FwOmKDrssQTM5KR7Rzvhu4AwaglIswPemtAPlsx6Rup6DbVzkuKI+bsY3eNGVs63HjiFw4g
	7j3yKDBbuDgxpKa8P7k6SgY6bTi3EVS+Br26TZVLzcX3euIb0nbzmftl4sViULargPhmSZb
	1Lh0aGgreroHquysWkc1Bjmy867BHh9t2c5nQm+KZGs4KW2JEdt7G6n/TODSdNEe0HPKUWl
	d/0RNcDlMc5G7Mh1JSdwsX/GDzCrcfyHMricq0zcWPV0S4yQYC3MhV/9Lad0Im8w1HYIiTE
	2gWIBdsmZvKEY90K3toxddlMXGH6KcMpD/5ZtyDkkcaDKT12tblp59zLtGB7oIqod/5L3OZ
	owpiXYrgYnmbxzajYnXZKdztTXWV1cdUhMsIbb5NWrSFpXoIi/jOuvpQ8D+auRJaj4pd3T+
	pTVXIAvI1qs5C4+mnnD+jNZQ19YA3qeJG3zJoO0N87giZtZFzofNtM6V2ZgBPCrPdNaqz4m
	+PpyqRaqq2Th0s77DkN22cHNLw2I8yISE5Bj9a1pHFujQtY3ubdpOl8iS2uSrdIHCyi6ebD
	6O66JyBL1f8bTq+oW16KgMeawhvYqIXasmBpUMjON1iNuQr4xq4riIcpSsO7JEE+vC9w7sl
	AHTgdJgmWOl1hdK7MFIbALXkIzGbaF59L7guZwQfxjc68pmEgl0Fm+gMAjIlMCQmHbYAcqU
	ZEVicL4TEIUvDkEvKEfoE+tS+k32cgb6tjsc+IMCvucZ2a9SUowzu6GC6srOZ/EDfNnAjli
	n0SEl3X5gArsfWPp3puOUC2arg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Nov 05, 2025 at 09:35:44AM +0000, Lee Jones wrote:
> On Tue, 04 Nov 2025, Troy Mitchell wrote:
> 
> > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > 
> > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > commonly paired with the SpacemiT K1 SoC.
> > > > 
> > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > Should we apply it now? The dependency patch hasn’t been merged yet...
> 
> And what is: ^[@kernel.org in your recipients list?
Might have accidentally messed up my email...

                      - Troy
> 
> -- 
> Lee Jones [李琼斯]
> 

