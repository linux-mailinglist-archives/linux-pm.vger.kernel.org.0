Return-Path: <linux-pm+bounces-41402-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Do6G4smdGkl2gAAu9opvQ
	(envelope-from <linux-pm+bounces-41402-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:55:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D687C203
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F47306859E
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE421765B;
	Sat, 24 Jan 2026 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBHnO15J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161A4A35;
	Sat, 24 Jan 2026 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219438; cv=none; b=ZtcmDpK99R9GeL2XU8UHgHctbEkdhiK/ciKEyWf2kol5Ta6VTKprzgH/wuAgl1+Gwa7oPV0+3JWN4xj/nqXsq/UKGovy6hZb1Zubt95X73rRI+LWzIBmPn4Y66WdcMfML6yZcNSN4zgvgBdUZC7eUjlD+CmXumUIvHueXjbqDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219438; c=relaxed/simple;
	bh=aLWsCue89i59IEHy79VKTEMC5w1S92QQkAmfyPmhXVQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dJouZPcMMPzOeOznBp3P9Ti0X4hboHNLPqGD+o8e7XXDMbyUGFSJms7N5/af8NXiiLAmHm8g1EX5kJlJm+tgO82Fbme5okXB6GBAinpxj7GVd/h0IgFmF2a8FR6gbDcwzqHlZCDGI/Bji4iL3kYpTgHgKercnyN6BtpXgR69yGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBHnO15J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3598C4CEF1;
	Sat, 24 Jan 2026 01:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769219438;
	bh=aLWsCue89i59IEHy79VKTEMC5w1S92QQkAmfyPmhXVQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QBHnO15Js1+od95cgo6dWN70nz4ysH3h9szIJRNJ1ra2oNVj6cM2w4BGBEsVac5tA
	 p5OT7ckHiYBroGgRUBQ4ewFnCcwIMGF626b8SGppBRuuEvvUDXkwJNc73RtYlxx0uk
	 NDTPpCP6hINMKMsevYFrTHheEHUcvHwRoB5iEQhKrHsInNxwQhohWEVsG+zagjCmXP
	 TpuisB3oGzL9TkIaVe3SMQ9IK3nuzh+VaOMlJOCbJpbf7IrX32bKIjoiBrKevOdQxE
	 qFJ5K05cow1wQY6Ep31xecjmsXLzBdTq0+2km2Zza93p4qNxekq41xaa1GlH35JFrT
	 mtEuPoB+2Qnuw==
Content-Type: multipart/mixed; boundary="===============1421871514063265094=="
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <baead0e0a77a98f1f54703a05fcc861f40d8f9eec0a24f96cf26df249dd1cd1f@mail.kernel.org>
In-Reply-To: <20260124012133.2451708-3-wusamuel@google.com>
References: <20260124012133.2451708-3-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Add wakeup_source iterator
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,rafael@kernel.org,lenb@kernel.org,pavel@kernel.org,gregkh@linuxfoundation.org,dakr@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 24 Jan 2026 01:50:37 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41402-lists,linux-pm=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[google.com,android.com,vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-pm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03D687C203
X-Rspamd-Action: no action

--===============1421871514063265094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
> new file mode 100644
> index 000000000000..ab83d212a1f9
> --- /dev/null
> +++ b/kernel/bpf/wakeup_source_iter.c

[ ... ]

> +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	int *srcuidx = seq->private;
> +
> +	if (*srcuidx >= 0)
> +		wakeup_sources_read_unlock(*srcuidx);
> +	*srcuidx = -1;
> +}

Should this function call __wakeup_source_seq_show(seq, v, true) when v is
NULL to notify the BPF program that iteration has completed?

Looking at other BPF iterators like map_iter, prog_iter, link_iter,
task_iter, and kmem_cache_iter, they all invoke the BPF program with
in_stop=true when the stop callback receives a NULL pointer. For example,
map_iter does:

    static void bpf_map_seq_stop(struct seq_file *seq, void *v)
    {
        if (!v)
            (void)__bpf_map_seq_show(seq, v, true);
        ...
    }

The bpf_seq_read() function in kernel/bpf/bpf_iter.c has this comment at
the stop label: "/* bpf program called if !p */", which suggests this
callback is expected.

The __wakeup_source_seq_show() function already accepts an in_stop
parameter but is never called with true. Without this callback, BPF
programs using this iterator cannot detect when iteration has finished.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21306880863

--===============1421871514063265094==--

