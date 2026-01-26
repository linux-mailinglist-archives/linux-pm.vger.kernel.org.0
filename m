Return-Path: <linux-pm+bounces-41487-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L1ABbGTd2n0iwEAu9opvQ
	(envelope-from <linux-pm+bounces-41487-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 17:17:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C628A927
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A75301F991
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE902DEA77;
	Mon, 26 Jan 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="BRYHe0/B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350302DB7B4
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444087; cv=none; b=KlJcsUhx6s6rFYUt93kCoidpttGVPRmbFN+5Y/omJa1VJ9evdoRUqgs6Hira76IljRZ+1J1tH2JL8IoKK1AF9j5ODMltuFze+3X5ChCsnInb0SmjFZUb4nM3r2iA7qjilvTSoLnYp60FBJulDTS2umqOOf5R3MpKP0IsdIsl78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444087; c=relaxed/simple;
	bh=b8iu2qWRQsu6tc3pNc2X9ucBCRQ4P+tsRyL9+lUs2hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=qahok5Rqo+i74nflr1u0Rrhq1J3IBbno+rcnNGUHSgBc2h/p7mLjmC7VAVKjIhG2YNpiF/VtZu6uKH1eDJZSo0OkjfwjHH7VAkT/j9IxOUli4yx3nLWHEf/AkgL1XOqOiwrBzc/iWXBrlVDWwfRu4UXoRiNYVZSk3Vs/iVmRfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=BRYHe0/B; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-40438380b88so1165386fac.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1769444085; x=1770048885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dEOLrKl+1dJwRUtD1uFFs3khzhZWFUaz5FEbEwHl00=;
        b=BRYHe0/BtgCzbZwHRIcGV+aaIJJSFtvt0sZoNP3Hyum9vk9WoQmUkeSUYL0IWxFcLL
         LfdTv355KSlZsHvHm8nsQTBdptJdltrGOpgKzWLgGEFxR0JDFApTH7nCPChGL1P900Ku
         jTfqGYFUVz+EhA5OZujPXU0kIgfoKLO8Npp58NmFqSCiL6QbE/1bkCOI9b3PPFkl7RQE
         RcrcFSOSwC5A2eXb4Ec3sDGFxTGwQEgmaKAs4Gc5KpVjbdJVrfPljbA+3FsBq1D4ePyq
         +NoS0ENnqoLvf/t4+WBVJcWoDID7R2tE9nRnC2eBdVVXLdgv3gU9Qi/5gBBft8h1fCAD
         gXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769444085; x=1770048885;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dEOLrKl+1dJwRUtD1uFFs3khzhZWFUaz5FEbEwHl00=;
        b=GZPu80NCpY0/7Y1SsHt8sXuuBkjGJuWtCjAJ6zR8S7AlIpuzl1azQWdb9j+RfyEs1u
         PEzkup/UztN7nZAAA1FgDgX0NR/BMmm54xDaKywv+Ig8rIG2ZWZYmYt31Oz1cx/shGBf
         jw75XD7BZlsEDy78s+YYYgptaKIaQ2YABXdcE14DHO0+Xma5P/7qFLFDVDpo50FNayzm
         21AD8iwCexw73Rh7etmSNdK3zsmjtLzwQ9I7qhX/M3Ipj5Q+E2syqlM4dHpA5xeTCrXv
         tFKQm/rdwRI9DAmeyfGHQH8hadoMSKIB82jbEyMttULTVXvAsqm/cgS3p0FRnW3WzPAZ
         weCg==
X-Forwarded-Encrypted: i=1; AJvYcCV8JXVdsTbSVgNy1pHUk7Dhzm7tUCH9lZCrgqv+Jl7w6M9HH8+Ct7CjuE7NTozTS01Jg14ysVTutg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTWLitiBFwj5b96ruJpk332/3i/5NuHxfgKdFPU8F6yW1QkKa
	+PXtmjbC4uQFvcbcRHY1v7gz3XwOhpToW38D79xU+nXyJTtDoh4z15tpPMDZ1yP+mNI=
X-Gm-Gg: AZuq6aIMnO6ZESY3kq1Ehl9eOOANRBQ7+1ClgsTMJ/Gx/gGQrtVtTWMFKjdAnykjt0m
	/Rb9GftAB8++pchklUBIXh9USZJCA/jHZJCck5GOV7aFreSyy/E7Xxd+b2V6IRpm2/362KwuA5F
	J8oQKuWIGMwowZUEr8xjlNeaDcAuP0crRGEOL0bjjjJmqO4lnEvi3OfVsDXLwf5FHkzzqRftHxy
	XvMEEzyR1VrcSgpFxajiqhVi2RI2go8+Z2w8IFVXAZs6JOseR8GdlcSWZifqreGI1fNDYy5Qd6n
	fnDM/Y+KmeQNOPBUpFkyq0rLf5EXlIew59B96fxKyo1j+AT/8q9ynBjolLC67p5BHza54m495Jq
	sTyjrR7xT4k8UY79bIVdDv/nXbaPrLecZIAf1ZbytBBCurMo75ojd4BqnHRV97JdzX/y2R9Se9C
	zcPxhKkqNoXwwMFoa4mCk=
X-Received: by 2002:a05:6820:c88:b0:65c:fff0:818e with SMTP id 006d021491bc7-662e045aa13mr1947679eaf.63.1769444084998;
        Mon, 26 Jan 2026 08:14:44 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:cf15:8cd3:4e09:100f:d91c:8765])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af80348fsm7389144fac.2.2026.01.26.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:14:44 -0800 (PST)
Date: Mon, 26 Jan 2026 10:14:37 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: yumpusamongus@gmail.com
Cc: arainbolt@kfocus.org, kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 srinivas.pandruvada@linux.intel.com
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20260126101437.338255f3@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <ddfa4153-023a-4f48-bff9-6d6a211b6d52@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kfocus-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41487-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[kfocus.org: no valid DMARC record];
	DKIM_TRACE(0.00)[kfocus-org.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arainbolt@kfocus.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54C628A927
X-Rspamd-Action: no action

> It also sounds similar to a situation I reported here [1]. My machine
> is a desktop 265K in an ASRock motherboard.
>
> The problem was fixed when I updated the firmware to version 3.11,
> which contained microcode 0x11a. That firmware was released in
> September. The latest 3.15 from Dec 29 contains microcode 0x11d. You
> can check by grepping dmesg for "microcode".
>  1.
> https://lore.kernel.org/all/53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com/

Thanks! We'll take a look at this and see if a microcode update
resolves the issue.

--
Aaron

