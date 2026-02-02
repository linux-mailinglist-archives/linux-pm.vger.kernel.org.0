Return-Path: <linux-pm+bounces-41926-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMUqAEULgWkCDwMAu9opvQ
	(envelope-from <linux-pm+bounces-41926-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:38:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D8FD12BD
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E005A300A392
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A962E7635;
	Mon,  2 Feb 2026 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3elRbe2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FB22DFA4
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064454; cv=pass; b=kXjZxAgapNNe2TXCRri1RWNaOQiQmn3+fDyg72Ny5KP5931OJOXlgricjHOJVLuu+yqsLkqrnUl1eUVVbqGoi0H/Q/cpi7Csmweh5CVSSJAyX11X7dONMWjZvPH0RjOhKzm+D548UZ5HArO+NxOE3bPObc9QbYhoryb9CFRd4YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064454; c=relaxed/simple;
	bh=EjTrHJGCKhR5boXRYUI+Jfk/dvUeA0NTVO3B5HxvjZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdm+iRP5SKGc/SRujR560bvby45MB9UacK0ySBwVJRtLVsmXwBFDcRilNSj1SV4VSrxa0XpJT4fcxAebISVOkgPU7uJZb5nBu3YLU9fOl7e95BlSbnD+D7U1/UwMgTcl78dHxGCRViYcl+3qDX9UFSHdSu0m2PHxAJz1KVP6L80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3elRbe2; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b88593aa4dcso664740166b.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:34:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064451; cv=none;
        d=google.com; s=arc-20240605;
        b=adTMXigmqJ1+ivfWL7i9dRXx4azqjYVtPQhI8WNax/MG1TcuMfT/lIyR54HgYv5otB
         ShvrY9LDAMtdsc9qNhfZIrlCmVfQnkdtGDFBR9TzkT+HEFQHWJSihsFg29g4m6fBj9dv
         Z9DKmXg92Zvb7KH+m9XqNpKnaFcVAMmDPblu1bds65NSVWjB+U35ICIJ3TsVLFCWEplr
         +r0Adf6pGEBHuBdKcD2eucXkuiDSvcoTcL2A4d6sLoas7vH0/pFYdhV4SvIERt2CoVJ0
         e8Lk9hkJw20/BfYS6um8VEKMHZbBCh0E6uP5Xkp9rVhtd0y5i5UfnF6XaP5Opq2Jvv86
         392g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fbUqeYjip+fDu2694PTri+FtAQxkD6UXiSLsVh9cQ8I=;
        fh=iRg8J+o7SO0kwIkHkPXonbVP08HDT9hUEqIZAzAvxpY=;
        b=bQoP7Vq55veDM5qtDSaOZo06lssJfL1aCa7b/NSSPjdT/X2LOS0wX8FPNsrMTdXgzs
         TWc4+VET8BeMMXpCaZK9zPnElfiBYDuF3Uh67n5+tfNbmaIOc/YlBaeVxa+pQnAntnkG
         eIwtPC/A723rrZctyNHfpF2Qsms89NySkSEKPivGXG5RGjGL7Zntq2hElHbPsSRTX4/f
         CTmgxfabmLgRXV8LkgkzjylCVNTpclaUd63Xf9JZDVJrBMo48vhy7Xd/WwZrjw/9k7QR
         41SKLgk8quENcfIV7V7wN8Sgte5OlpW3vCfewCic3e8GNyq/9zoG54xiPMcO4/tjwJlH
         g0WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770064451; x=1770669251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbUqeYjip+fDu2694PTri+FtAQxkD6UXiSLsVh9cQ8I=;
        b=p3elRbe2EDd1D2oRb06vHZgZGTMcmwQskgU1EpGm/oAB2gLoLEGe5p/7VrymgkOW0o
         HXRDCXq1iUwgFkYl5TJhkYsksO2TAi/HUFDfvN9zY4skS8dp6mhzMPX7g84CSGqDNbH6
         5q+D0K522ehaQ1VNHGoR+tMy7oC/1485cRPBMLWjHch2LAxo0lLAYambiKY1KSNnLl7H
         kYUYHsty14rIQaLGxOK5pcR54C/xIPEAFgrt3Ph2/ZuOsRr8p+LL/uu0infH3Xa5wU7V
         9SgEtY5putD/vCXtpb+9kbSlYW5yLLXb/ML6vGuT91gD2QylJQ2cILM15ZcJ3dVNH0+w
         z4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064451; x=1770669251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbUqeYjip+fDu2694PTri+FtAQxkD6UXiSLsVh9cQ8I=;
        b=QkzwBeJaOuAlbeexSYFFnMDS/rz2Y9SkkebjivjbJz4i+M0zlmh7iNgN9rIEIE2wZB
         eqtWeNcQMKKuJbZQ3VUNLn30ltu2cjJoyvXurTnqzXW2shpVAm6PlC1YXDHLuTYEzF18
         KjOQA1a2A8cWlKZclPRGTiBczRJxndozGWMNA5Gasr88FnFAAWpE72hmANwJKEPtbSG1
         q88jilxtlQYdwthr3I4kdH330wvJ0espN187k9+Zclz0DeoaR4STadc/ZDzQrm0VoGdT
         FqoIVPbyWNQwpGlOAtbOWzUjtOvaKDjnGze6fASuxxd6MXhq/jHBQDySElTfIFRm6wam
         oC9A==
X-Forwarded-Encrypted: i=1; AJvYcCUdDA5DpyZ/xSDOcxFxue2Mkn6v6ErOgbzMfOHrHW2L/rv+W1J6erFYBoKVczkLe9rGcwHH0MiHgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzptxgSl/7EjmCvt29xQS64fGRzrVq6iWAIyB8No0tEDDeaOqED
	x2Aq4StlzdqpsqBebs1bMmjHefTzG02s9haJNC6l3DlhgwDvf6wDb8gE/daVDDyyxjSv5S2tMl4
	21yeeWC4zadRUVPsIumXEnYZiZF1WdjCiNDKzC37/
X-Gm-Gg: AZuq6aIuSEdxItbBwnjxsLLG74JqDVNLpu5fGpZQLTLvJDlS1p3XWmkFTignDgOPcHk
	yxedInKyRJKxTbYAbeqVc/GnKX9f/7K3nl0Dd10PUvA/6npmw1VZjr5Mysm8vWn+cQX2AXsFJF/
	Wgw1PtmQudn4Vo8JE27yk24RG1fCdsUK2eFdinjcYNn3Svl/nBsTUVQkVDtPHMU5tpjY3K7yHnN
	Navq9MadaQvCkCC4MPRK0cWS6sZNLQ/f2n4qV3k5R3G9sDE9FHs4asyqHTHr/9r3K5Wg4c7J+RS
	wlemp1fWrkGPZRoTdVhxKNCwGw==
X-Received: by 2002:a17:907:968c:b0:b7a:1be1:983 with SMTP id
 a640c23a62f3a-b8dff8071femr749742866b.63.1770064450976; Mon, 02 Feb 2026
 12:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-3-wusamuel@google.com> <baead0e0a77a98f1f54703a05fcc861f40d8f9eec0a24f96cf26df249dd1cd1f@mail.kernel.org>
In-Reply-To: <baead0e0a77a98f1f54703a05fcc861f40d8f9eec0a24f96cf26df249dd1cd1f@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 2 Feb 2026 12:33:58 -0800
X-Gm-Features: AZwV_Qg9DXmMmV2h_Maz_0xWq2nHkrts0cRt9nDGe687Gic8SPCzSfFDm2mNxs0
Message-ID: <CAG2KctpZB2EnBHccEYqGMjWiAoE3+HzV-0vpu5J8tejg5opNUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Add wakeup_source iterator
To: bot+bpf-ci@kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41926-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,android.com,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 50D8FD12BD
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 5:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source=
_iter.c
> > new file mode 100644
> > index 000000000000..ab83d212a1f9
> > --- /dev/null
> > +++ b/kernel/bpf/wakeup_source_iter.c
>
> [ ... ]
>
> > +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     int *srcuidx =3D seq->private;
> > +
> > +     if (*srcuidx >=3D 0)
> > +             wakeup_sources_read_unlock(*srcuidx);
> > +     *srcuidx =3D -1;
> > +}
>
> Should this function call __wakeup_source_seq_show(seq, v, true) when v i=
s
> NULL to notify the BPF program that iteration has completed?

My understanding is that above code is invoked as a N+1 case after
iterating through a list of size N. If desired behavior is to do
additional cleanup not already covered by _seq_stop() (e.g. printing
closing footers), then v =3D=3D NULL should be handled. However, there is
no such need for wakeup_source_iter at the moment.

>
> Looking at other BPF iterators like map_iter, prog_iter, link_iter,
> task_iter, and kmem_cache_iter, they all invoke the BPF program with
> in_stop=3Dtrue when the stop callback receives a NULL pointer. For exampl=
e,
> map_iter does:
>
>     static void bpf_map_seq_stop(struct seq_file *seq, void *v)
>     {
>         if (!v)
>             (void)__bpf_map_seq_show(seq, v, true);
>         ...
>     }
>
> The bpf_seq_read() function in kernel/bpf/bpf_iter.c has this comment at
> the stop label: "/* bpf program called if !p */", which suggests this
> callback is expected.
>
> The __wakeup_source_seq_show() function already accepts an in_stop
> parameter but is never called with true. Without this callback, BPF
> programs using this iterator cannot detect when iteration has finished.
>

If I understand correctly, this is not mandatory. For a
straightforward iterator like this one, I'd like to keep it simple and
not unnecessarily handle this case.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/213068=
80863

