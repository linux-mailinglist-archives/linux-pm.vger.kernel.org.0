Return-Path: <linux-pm+bounces-41924-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK6cGzgJgWkCDwMAu9opvQ
	(envelope-from <linux-pm+bounces-41924-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:29:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DC5D116F
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DEDA305ED3E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D02EDD7D;
	Mon,  2 Feb 2026 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i35lvgzw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2032EAB6F
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064056; cv=pass; b=W9nkIDNyIz/V3Tv5ryRI+NTxFOjQl2wJJRQZfuPjAsaUAynwlCz63/noaUAiCZgQlxDMtT2LxFEQHPYkfj3+UXfndwJ6OyHhZ2M0PXtKA2fGlmzkt3uCLl63RWcsR5fOfgdLAx93Q7brbdIZYjAeFnwdIcPoWCab2D+oKdHs1qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064056; c=relaxed/simple;
	bh=jfXmnznKLJiTPbD5h8TXzPoCYSLFywcnZTDixTwqnvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvYcPj0TsWgCRbnUffbFnEkbjs5NIqL/+cK2YbNgHb1lT8CIYXqmnpPOKpiYNgLKFZ3uvliYK3u1a2OZpUaTxt+v3H65N7UaPf5RRktXaY2GheIVXpCoTGDXnkX15oKZ9nAQMHpPM+go+4d0oGnfg8Vk41q2ZCjWIjIa3LOGfqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i35lvgzw; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-658f1fde4bfso206825a12.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064053; cv=none;
        d=google.com; s=arc-20240605;
        b=M+B6mNHV5crK+aAvsMHs0TnApRnW/Q+MEXhElqrUsrhhiKig0oBmNJVdx+eQVU5Fx4
         l4SFZznphXkyunCs8AlqMpBzu7Bs1xtJIwIC29STZK0QeC1VhnR35Yqni5+sTXYae/93
         fPDOcRexPxbNofOCfMWkKmj0o/058QzFpof2QR/Z3Oz4C0eWZkm2piG8MW3s1Lf2GJz/
         3HkDWfL7EW2+QhXdvToFAucn2ET8gOIJ1yvbm3vxp/EOXRbshZpQclADhAXB9mLq4rxF
         /KnDH6eu4N7iRYaX20H8JIXhxkcZOlUPDx2jxt6rw6Iq6ayJBo+eI69+PKKCAB6rEkXt
         9zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tVRk+zilHW9UjKLQgTp2UA+pwv3RE3RSIRFfK1s01Ps=;
        fh=VXl9itEsyC0Pf5rOnBXtR1oCvtF7DERKjI1OjM6QRbQ=;
        b=IG4xjNzobPCF0suVS60bSXywJHp9vZN18+kiAn8SbttvjTz0PjW5oWiDMxSfgX0mO8
         xBkwwhUahCSQrKUtDalRc/ilQjR8yBbeKR6BXSlyvOTfAVJ9TWh4BzVsRFF2+khzoc2I
         FZBgrzecyEMkI1eTn59ULdal3HYrEcjeiVUailfte4O/Jamqdm8at8AoWUrMiIdFTd4F
         rFBUpafG75Ve1vUNIj2nlg6S6O+/V8C4cw5UufomZ8atPpiEunORgtDLkZlna/GxiCkM
         4mYdAGthJGv2vD7rxvwFJB7oLtA/FC0MgOPU3O8BNOME92KMxQdRwhRHGzYAVs6YxcHS
         YooQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770064053; x=1770668853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVRk+zilHW9UjKLQgTp2UA+pwv3RE3RSIRFfK1s01Ps=;
        b=i35lvgzw+EpxLEACaPBJPib1skMRWoVPBETG80k2waGjMfR0bvTZjqFY4pJKbGWn5E
         5z5qZlpRY0MUjIuDeqPiYZ5mJsYcukgBq4FlMWsg5BlznYf+Tb5OQV5igiNXwUBcKK8h
         WanbW26nVcvkhzR6FzEL08DsaIBY1+GGPt4MZnGjaXjCQNR37xzJoWZal2rtGXPrqIhH
         YTiFolGNtNFzwocVne0qhe4Glb8NUm+b4eM48yuDO8eM0RLgYVgm3aCewqU8C3vJdBRp
         aumxQz3314vbyn9SMtuvn8s8DXlZfqEzcjauhwS7efbvBqHQVb8mQ9U15CmJgt116OhL
         xI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064053; x=1770668853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVRk+zilHW9UjKLQgTp2UA+pwv3RE3RSIRFfK1s01Ps=;
        b=p9gcUyW3mUN6RX/s0QF+tJq4JbWySU56z6zzkVjCr+E7Bu9Uw7Fr3jzDy6FwDugwW+
         F60ImzQCMlxGRhDcamlrT7deOCX1sYeBuYXbHNuRISMELxm3y2s/G38E9oJ5g1/rugER
         FyOLLRQcWKhIbiKtvjKsJWsqqRtzUtC3hqTWGzXwmCElAy6q6uEbDm/k4MgLPeBl0UuX
         e5Ky4viUpSB9TiFO0hoffAezERhtbm6V2ahWRWg27nUvFuqiiTtapVPcm2COwItsIRyf
         nTHg6MwP93+R/rJ7O31loyfRz3uFY1VJb/P7gUE4OQ/jWCl7q9Yb+1Z+wuHlGvtDfJZA
         7riA==
X-Forwarded-Encrypted: i=1; AJvYcCWSlfmU9tPlGEFW2ge88EfCoaKztHhAVZidIW5yMv8rLq6ScEoKJwj2PL4dEzIN+JYa0s+68ZLDhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4Qlr6ewmu1iw4h1K/Ak+glaxewFtJpAbhNy7i8r8RaSEBAZ+
	FQib0XS6K5gJwlbSql2O1aajBQ1BP3peWPCGjQ9bxw1TLHo+cIPkDRVpmNq7aRLTRkhgVtugwHf
	37NcxmpPcMiTp42cQuDW/cO1ziuaBBmfRdnYrMfXB
X-Gm-Gg: AZuq6aLUZykny2Fbz/DHo9PoC0ZhsRIMwHqwH9Xp58yBfI5uEOdqdyhPqeFckYLy+jM
	xU6YrAqfFoUQqiY7r2vdx1e9Z9Xnb9I+0K4f9vAcz7ZOBtaYYLHVSXj0pqZLqgTGv5mClpcke1C
	qpSOHA69aocLumtRSnI54X4vI0G+SmVFkmfmYBCxaP5ZzuYErTGPXuOXxxybFbXKLLM8UnDXT9j
	QDlFx9DbjGa3O3s3g3UYYEn+iNvMAumcKDm4hAqetfcwV/T22HtBSIUP/NBjba/CMTvO/SCw13T
	5BnGRdBrtsZIY30cY6Fq7id2ACMgbvYUY8mV
X-Received: by 2002:a17:907:7252:b0:b8e:380:5669 with SMTP id
 a640c23a62f3a-b8e83909daamr46612566b.32.1770064053184; Mon, 02 Feb 2026
 12:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-4-wusamuel@google.com> <9f904e57ca365036b12263b0d0a06b915e6090631df159d17f4e8a9651c1f5ff@mail.kernel.org>
In-Reply-To: <9f904e57ca365036b12263b0d0a06b915e6090631df159d17f4e8a9651c1f5ff@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 2 Feb 2026 12:27:21 -0800
X-Gm-Features: AZwV_Qg29xnGZqAdFJeszWEWENOogIq3Hn6LIMQK7pgNDZsdLvyvbyvFqAYEMNc
Message-ID: <CAG2KctpjRWiLEur+27JZZ0bftDfBLj-dy6TA79iLYk-DQfr2MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for wakeup_sources
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
	TAGGED_FROM(0.00)[bounces-41924-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9DC5D116F
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 5:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.=
c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> > new file mode 100644
> > index 000000000000..c8a38717e284
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
>
> [ ... ]
>
> > +static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *it=
er_fd,
> > +                           FILE **iter_file)
> > +{
> > +     *iter_fd =3D bpf_iter_create(
> > +                     bpf_link__fd(skel->links.wakeup_source_collector)=
);
> > +     if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
> > +             return -1;
> > +
> > +     *iter_file =3D fdopen(*iter_fd, "r");
> > +     if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
> > +             return -1;
> > +
> > +     return 0;
> > +}
>
> If bpf_iter_create() fails above, get_ws_iter_stream() returns -1 without
> writing to *iter_file.
>

This should be fine, if the BPF iter file isn't created, we will not
write to that file.

> > +static void subtest_ws_iter_check_active_count(struct wakeup_source_it=
er *skel)
> > +{
>
> [ ... ]
>
> > +     char *line =3D NULL;
> > +     bool found_ws =3D false;
> > +     FILE *iter_file =3D NULL;
> > +     int iter_fd =3D -1;
>
> This function correctly initializes iter_file and iter_fd before calling
> get_ws_iter_stream().
>
> [ ... ]
>
> > +}
> > +
> > +static void subtest_ws_iter_check_sleep_times(struct wakeup_source_ite=
r *skel)
> > +{
> > +     bool found_test_ws =3D false;
> > +     struct WakeupSourceInfo ws_info;
> > +     char *line =3D NULL;
> > +     FILE *iter_file;
> > +     int iter_fd;
>
> In contrast to subtest_ws_iter_check_active_count(), iter_file and iter_f=
d
> are not initialized here.
>

Ack, this is important and I can address it in the v4 of the patch.

> > +
> > +     if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
> > +             goto cleanup;
>
> [ ... ]
>
> > +cleanup:
> > +     if (iter_file)
> > +             fclose(iter_file);
> > +     else if (iter_fd >=3D 0)
> > +             close(iter_fd);
> > +}
>
> If get_ws_iter_stream() fails at bpf_iter_create(), can this access
> uninitialized iter_file and iter_fd? The cleanup code would then evaluate
> garbage values, potentially calling fclose() with an invalid pointer.
>

Correct, and this issue will be fixed when the variables are
initialized as pointed out in the previous comment.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/213068=
80863

