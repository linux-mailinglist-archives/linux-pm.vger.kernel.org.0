Return-Path: <linux-pm+bounces-41591-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBzWM36LeWlAxgEAu9opvQ
	(envelope-from <linux-pm+bounces-41591-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 05:07:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E11499CECB
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 05:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6782C3006203
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064F2C11D3;
	Wed, 28 Jan 2026 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWlzk5VQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041151A3029
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769573242; cv=none; b=j7HF2z7Tqicpj02wuvBYP2OYH9RAlfWvWO3Q1C4QiXEOn9zgFk5+LLXguF+6qcMw2vIdzyQwO6ECCa10gC9gYVSDQRiEQv7N67cIk8LIIMN7GYR3kR50Vr9Vf3VwXuvW5DJFnvezNYwbJ5HnaEuhpuuHrLAXErbrf9mKZNLq9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769573242; c=relaxed/simple;
	bh=ha799mPK9ni9PIg+HKeiazrRjc6xFUg8SGwdfgY3x1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soYIo0sxlVdimwTE7/FE+vyLdsC8OlBaznFOgnG5c+wFvc9I0eMG/8TRVleijFST3YeH3EJT3I3jNs6gnfslb3X+U1E1QZ1Wl6WqHyQuSBe8nwCCSO2F3oLBBMhrXSFQisrvGFuAtXx/JzKKDNulrRndrcS/dRleZW0hImPyogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWlzk5VQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f4e136481so3218569b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 20:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769573240; x=1770178040; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ek+ySAvXRy4KK2EO9y95bP/QQCKm+QE31dQdXwoRcf0=;
        b=EWlzk5VQzATDEB8hWYcK1GclrdtEcs+5NGrFL4FftNMBuUny+hq2Lj911RJKnHaEiI
         WFLpm5FxMBdmpviHsvpNQDw4YGF8pRZ4DZ7QywBAB++ErhFr1ZMNwdu/MzkDZ69TzqfL
         0tIvgdH/Y4rNMAbVvMcHMEnq/FMSE6DMemSiXO8BkJ8v6UWVOjIHiHxD2V2NpmzjCsNn
         0rdBhCpjRU2b7f+YbuUCceZFjxvDTMRj1/Gr5ufU/89DCmQTkZ2L6i3b6iGmqtvjb+zY
         A7j3fx75zXlTIzh8n9VYWsUa+rw4uYO9uGuQib4wZAtc7Mb9NUACDo1bwRSJ7Z0TfaHc
         HYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769573240; x=1770178040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek+ySAvXRy4KK2EO9y95bP/QQCKm+QE31dQdXwoRcf0=;
        b=RiNR5ZvwaVMJesZw1nS//4oBfldQuxYndUh03IRoYVAba+1p67ma9nzk7tbyo+LdSj
         2YD01ujtUZJC93KhotiWt86gRHWGNEeMvypYWvtODzdSC3nYiJhHMEnfbMM75jnXKJ/1
         wGpwWp74hTeW+3qGrNuQimtlGhDeKALH4lAoO9t6anhtd8dHkn9soIfDLf6eQV6sUOA6
         8xaxrgPc81mR4fSKLGOkZzBEJxrRs3e6sngnO5Cc2uGnGH+5IGzHC8uQeIUqkl0ftSmn
         H/pXTtSwA3YpcZratVfiEIVCFXDVkX8iRSTB4ysiTqT92JxBtxh9DgycAiL1iA8Lhr/8
         Y1Iw==
X-Gm-Message-State: AOJu0Yz/l09OhwAwL2fdJPB5YKGTIk0kvl6th1LdqotNSRov8w6AjkL7
	eP/8lDhzli8U0Bt+All6pDakduml6L3SXnbPnDk1aKKhfOmEWfZESA34+QDA64TN2+U=
X-Gm-Gg: AZuq6aLtnR9H6jI90ih0P6GShpNWpGYplTcOmOZr9m5uLSW2ERljxt4mxelJBcuyghe
	nMJOJ338SLnwP3vJlWF8HOGlv4jtSdm3N67uZxE7+37VGaIXGzR8RGmmfhzvQ2l6xids1gJ/1IO
	R+1PO5zfbviuOSaur1jRB72vNgvIYJPmKK1/rzbi/7hKhQRLYPmzcwk9W9KDNVLRwWuZ3qAis6c
	sii7PdaXlQCAT2xn+ilPjsAdf6LJOX3WnG8JEvwS2GO37TISvW2PUtCZVm5TetPOBeB8nJf3EQh
	NpD6aOQBLRcVREOu1lszplep6o+wPepaaFVPnyn3WHTsFww57shzFJeuIrhkaAE//MKJGR6Qraf
	pGtv0gp5PnlTUqTGNNQeJMumB1QytumOA94729G2J5IYDVHxy0yjR0aUslXwlHUvzjjtygoKXVN
	VU7eSOmYDhVSQ=
X-Received: by 2002:a05:6a20:9389:b0:366:14b0:4b0c with SMTP id adf61e73a8af0-38ec65804abmr3950979637.72.1769573239929;
        Tue, 27 Jan 2026 20:07:19 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642aaecd19sm833127a12.29.2026.01.27.20.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 20:07:19 -0800 (PST)
Date: Wed, 28 Jan 2026 09:37:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.0
Message-ID: <fanefxv46yew7hgr3c43kv2mccrtwrtjbc7nfpqx3ykpnbpd2i@e5tauhoemi5t>
References: <j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p>
 <CAJZ5v0gH-g5H4fqowtoNs1ZTDWR4xa4Wd9Db2uSJxjWW_KsZVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gH-g5H4fqowtoNs1ZTDWR4xa4Wd9Db2uSJxjWW_KsZVg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41591-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: E11499CECB
X-Rspamd-Action: no action

On 27-01-26, 14:52, Rafael J. Wysocki wrote:
> Hi Viresh,
> 
> On Tue, Jan 27, 2026 at 7:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi Rafael,
> >
> > The following changes since commit 7e3debb4c72fe840d60014192cf93950871fb3be:
> >
> >   cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list (2026-01-27 11:21:22 +0530)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-7.0-rc1
> >
> > for you to fetch changes up to 0b7fbf9333fa4699a53145bad8ce74ea986caa13:
> >
> >   cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id() (2026-01-27 11:21:24 +0530)
> >
> > ----------------------------------------------------------------
> > CPUFreq arm updates for 7.0
> 
> Is the 7.0 thing official already?

I looked at other pull requests and many of them were marked like
this. Moreover I did hear some discussion happen around it at LPC or
maintainers summit (not sure which one).

-- 
viresh

