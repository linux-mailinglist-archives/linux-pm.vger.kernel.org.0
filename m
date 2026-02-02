Return-Path: <linux-pm+bounces-41923-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNXED+oHgWkCDwMAu9opvQ
	(envelope-from <linux-pm+bounces-41923-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:24:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA531D10E5
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7B03019054
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B92E543B;
	Mon,  2 Feb 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5aTzo61"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951B2D77F5
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063839; cv=pass; b=R8ETFBMUsBg2eMiAJ3L/JzZbVuRYXPsKVGPsLl6m1RZpTWdcIEuEZ2C7b3kAizsTTt0TcAwu0lvWUEaW74ieZb6dOXFUOR6MSvHdsUI5zbyaJHEd3umFoMlt9gvjojbvBVZ/BPYwEho/r+asHMCimBKYwTGrqZ/bKCJpIP39MaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063839; c=relaxed/simple;
	bh=rygccUd18l19TzR5JCjH1aG9Ieh85FWBhgGrodwQfAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+Lr6LWl420tjvklGWMy3cF6hXNutcYvThbNEgbtuUDGMEwGY5lzn91R1G9kkyOG6TzGqmREIU+MrqIHqUkhnLShJVK1J1s2wGkq3CN3r8FhT9CM8KGkU5rX5jqrGpoyXKXgiWCkYMr9SAVF6JLXd1c4BxwfUfQcIH6n6QNg3Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5aTzo61; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so226204a12.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:23:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770063836; cv=none;
        d=google.com; s=arc-20240605;
        b=WBW6YdoQaVlAAAK1SQQdvOMKPThW55XftVaOjOwopcTZy2p/7L7NRH/qrS+pzOAfcu
         Gqj9M5ZbnEdrvVrwzwzuC1RcI3I2aTCcfi5X5vtoIekBWKc/DSOLdycCBeqtAFhbq7+P
         dg0jwaakECeDKS53H0PwjzL/HRn0QkRN/xlpHL3xKTfM5kpg3PBU5gNIIB+njUFVtvvD
         DzuWLOj87LF/IxkDbcBOX89dm0fVox8LD5ovAYqmIt7peyxSk5yASQkXgp4PcM3wawYx
         pUGdg8/M7YJ14Hbnuy3imD49bH5QWuw0iJM8nqiulg1V0SW2G7TPOwNkjGb5fa/k22eE
         vn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=htIZPWHbD45Ax/xP9Qw9uEOw6k3b0vJzapO+gLliJ94=;
        fh=f4e5zI1ouuYB2h+MMC45WCfJUAx4weyERliNlduVxNY=;
        b=fqyJHoP175O1Njgf/rhlxD8R2xlaRC+YKooep5q/8dyzzs4+dyQBWQxM7/lgYTW6cw
         rfhsRtOzfQoiolt18XTSxc5PhpolD8ikqnpYJ9vuKbgLcPJ0XaFy7IM9oz4RsRVCH0r1
         QkvkneYN5iywJVqFtUfGPmp7LjPvEUuhgasOOzXWoGn9fcmnsQOgqJ1OImdwWKlrxwHr
         vUG5VrP8UE2CVn3xEz6vKi30yeXMrxubJ44m7LQlf/2ga4cUdrAUdedFZH2SxN0ydj71
         TmfJaBHGEyqi3xiVDRXk1Y/2GraPgtkjSTwvqgELWBk55MExWhd5HKK6yLHW09/FW4Gv
         i94Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770063836; x=1770668636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htIZPWHbD45Ax/xP9Qw9uEOw6k3b0vJzapO+gLliJ94=;
        b=U5aTzo61c9/GFsxEM2m/A/746Ub8QrtfHQpE1rRZ5Vf54hERmqP4ON5eB4HH08LM+7
         UI9XsRK69lkdz/LYxPZq52tIGUNny7M9dnq95j5P7Fmyp7Rw5Q6Ogr9TMk5I7pIpBLhI
         NHz2enOQi0U4FMoF9/xgSFOAPf1z5kw8vrMQVJPSD2LucXCUtI+UBn0hlm3CyVTknHMF
         K9t8VVvcZY+rQmf1yXA1kkzjBa+2daLFLDEU3vQih+VOcMi7/XGYzayGFKCtltNStaUX
         bD2joBB4sBs1iANJaqA0UI7jWhqVyTZIJgXXiNlK5ei6bmSxOAHvOI868ew8CdZljfGD
         GabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770063836; x=1770668636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htIZPWHbD45Ax/xP9Qw9uEOw6k3b0vJzapO+gLliJ94=;
        b=gL8o42jss1QgQgSCNXAHIShJs/2OHyleaZAnkwSqyFHVkR5z1qrT9JdMvafDkKuNX0
         BqfkKVr+TBMlrmhdNwbKz7+nc4T/mf633Ed7vD7QTXS/X6eE8PtAo0rlTTJGYEJNmyjp
         5dXL2lbk/tQeWRDzlSU07Bll0Wxc84ZJKBkMqKD5KE5F2pPZYBrbzwulMgBykfYceMnE
         CcfnSui7uIUnXgGaVXrrDYrwmInpc5x1CS93rT+/Gt+CyPQdbpgKOdulkeJFnzevwzFK
         z6MrqbuKLMu15n++sykXVEV3czKCd4zzjlf3Q6CeBihhXXS0WpvlaRQC7CORhXm7D0f/
         mTEA==
X-Forwarded-Encrypted: i=1; AJvYcCWPkEV2odJcRmF8kebVWwkvP5q7aPOa8BZ+gG5gRfIQQxKowx8lLp2Rzi6uTpby3jb2wQ0REfNvPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmjkc7XuMMuVUbBsxWzm30EWq/28QQvAfD53e7Ys9AlM1zI9nD
	UzZIlEzimgumHIoSkpsXDOd/Zsj174z3NHxpXIoTNi+wCRhYlEjD6Zg8Xk78RbSeMad5F/weN/i
	z+S0OAkhxk5338ryOHqqWDSAJ21AD5SgR3FTpckEL
X-Gm-Gg: AZuq6aKWQ2VdGaj6falPEKKx8kN5gnavT3cKuFpTKiQzyvwVaQXrj1as/2Ku606HVRu
	B6XCzDSOjUp5J9StiijTuSHpdvBGP2+4kTIKMn3w7eAEuSZmD4n0daq0Gxdov/9zuxG/WogDdcp
	8MCYCQRMPWKJPpNC9mUZyeS67RnVIQZGbczPrFlv8scXIKpgLNlwn+ZJ3kDUwj0ndNhV1tbfMMz
	19KEtTqwWmW39uAoiNHbwKZWQf+ci8HD9l2Hzhpm24ZzHr36ruFLBm9ko56vsXOQsJc/fxh/Lxo
	irf+z8TLJTlZ8Y2DtUW5wMTJ9w==
X-Received: by 2002:a17:906:2092:b0:b88:5894:6ba1 with SMTP id
 a640c23a62f3a-b8e8384b261mr34088266b.28.1770063835546; Mon, 02 Feb 2026
 12:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com> <20260124012133.2451708-2-wusamuel@google.com>
 <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 2 Feb 2026 12:23:42 -0800
X-Gm-Features: AZwV_QgqKaDjKsxdqUkpb1jGTSFawd3uSAT91ZuKQiHw4J175hzMfkuvra288U8
Message-ID: <CAG2KctqqZ_12AWiJ89OhCfqDfNqxBH3UrzssycxrXbcbj-82VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41923-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,android.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA531D10E5
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:15=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sat, Jan 24, 2026 at 2:22=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > In the case of an empty wakeup_sources list, wakeup_sources_walk_start(=
)
> > will return an invalid but non-NULL address. This also affects wrappers
> > of the aforementioned function, like for_each_wakeup_source().
> >
> > This patch updates wakeup_sources_walk_start() to return NULL in case o=
f
> > an empty list.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  drivers/base/power/wakeup.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 1e1a0e7eeac5..e69033d16fba 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
> >   */
> >  struct wakeup_source *wakeup_sources_walk_start(void)
> >  {
> > -       struct list_head *ws_head =3D &wakeup_sources;
> > -
> > -       return list_entry_rcu(ws_head->next, struct wakeup_source, entr=
y);
> > +       return list_first_or_null_rcu(&wakeup_sources, struct wakeup_so=
urce, entry);
> >  }
> >  EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
> >
> > --
>
> This looks like a fix for the for_each_wakeup_source() users.
>
> I can apply it without the next two patches.

Yes please. Feel free to apply this patch independently, as it can
exist as a standalone fix independent of the subsequent two patches in
the series.

Thanks!

