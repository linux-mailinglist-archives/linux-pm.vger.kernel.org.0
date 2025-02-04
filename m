Return-Path: <linux-pm+bounces-21342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C23A2772F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541C18842B4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A7215165;
	Tue,  4 Feb 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAm8wG9D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB32C181;
	Tue,  4 Feb 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686648; cv=none; b=OYb3xU0EuUY9dIouBWQSrllhQlqtkz7oUpjboeV6YpZIxGElUT9Fj//GDaqGr/zlCz6Cv6diEHV/cxjzCZyO7LZ74P/IW9jvvkyyI0pgid8U+2OKkP7Lbb6pZyIdwzCfd5guYgTj2WcjRcX+q3V8GMRJtuqbUcgaoJq9U/guOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686648; c=relaxed/simple;
	bh=opT0EkNK045NqLULfxBak/mtFGh/D/EUUcxWawHwc08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryy3+dkkMcfsbRUxbUZt55XGwEemt71hodLBqyq+henmFQBTNXaUp4c/FLZHyKTr0wah2mSwWJcX8lqOo3N28b2wY6QrYDojMyviXoNPZo1sqIBflMvOTQAjqFPwjvjdMIiS8fbd6JrlgH6sQVkL54UJZKJWIRRh3Kpiv+iBlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAm8wG9D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7430e27b2so300153666b.3;
        Tue, 04 Feb 2025 08:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738686644; x=1739291444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opT0EkNK045NqLULfxBak/mtFGh/D/EUUcxWawHwc08=;
        b=bAm8wG9DctJrbfa/3W5srXK7dIJWb2HLbk+eb0BffYNnXSBBqgD+B9Q3MVQU6dJo4p
         N4j4B+uYh7Qhuo3H0/1hRHqPlyeROEc0wrVNkmx9JrHO+ztsdckCeStiyLLHBNtKa/XV
         s3kcRgrSdVbnvUwrF0eohr3cb3U88HNtZplARuOfaVOHdJgoDliRVMIbQyKG1pXDZdEt
         u4vxeuKtbsev3rleHveMnqv1SbekWIc23FpB0QdNZ/CjBO2SzsVYCWQF2EJOMYGiCWKZ
         mzY2ZLUw8seI7na+QYo4St2uP30jzeBYt+uMY2//kWJCOmQs5DH9AWPsz1K9ZaI6mU+r
         lSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686644; x=1739291444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opT0EkNK045NqLULfxBak/mtFGh/D/EUUcxWawHwc08=;
        b=RDoZhXWrLst4a7LQ1rrP0JdGH5hNAawavmTUBDE0sMxNaKBJxM2k/gELe2ga3O5A5X
         U5XN/on+mU68fma9vFNBXFPzJxYYn+ls8e09UYezLd03QExccxOadqPRwRuEljPTko9j
         rIqMgdVE6aok7LmVtMC3CzJLz6VSMnP6d74WD73uoFWhGhrkPpB46N4AUI3p254XHkHv
         i01XZ+LeIMT4zcH6xcEDtqzxYIpMpyoa9VGgSTr5aSVoE1qd+vaGfq+y2gK1PRispmlu
         XF8B1ityKjhIpSaUEcwTrh7K+C7EJqJVrD9uXnI3lQJlWNYBYP10169gdE1xMIKUcMjn
         +LOA==
X-Forwarded-Encrypted: i=1; AJvYcCWwgwtP2Jshpmj711pqT4NtZz13dv9f2/tviCaTaO0xPEk33Jmqe72KAvulrbd5gMZdz7fn3/O4QFo=@vger.kernel.org, AJvYcCWxq0Kf902YN8ctdyBBBLVCkW1sibBM6jQbpvDkNutsihhZNLKlsvo91fHgAeiUhunnjUV7iPnBqPksEgiH@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMBMaQCBzlcaE2hVxEhdYLsBRBhjQncAVKkq0AdagO8/e5LIl
	AXVk4FdKOnZY0ygIqn8jQ9O+8VMXZtQfCgk+P03f0537NF9/OZbd
X-Gm-Gg: ASbGncvyYlXj07iKRpTkGy4k0qbdYXoHvLRES/h4cLP5OxoZC0ErsgN8gidcXofpuUj
	MtibQVKRSUChwIsbn+VWC4o/spFwnT7vz7cRbn/d4wLCBoQfXN4UsU5xmIcO0Slab3tsweCgSyU
	QA9LHbdFqyU4dMmcxneCK6NQOdpfaeyqFX/dzOLf9lnDcTOgkoDRXPM96qTHgBhgp4a3tzcM1ik
	BKFi47xuD3lgcWhvjDOsRa2i2VB4VMYIFUa6LBomdaIPgCCWd3JsIjC/YGvdFYdcT7cyVD7TJuO
	UWfCiDTXImLkTXtVs20WP2MBjXgblNhJZLEH0IusZmGDOQ==
X-Google-Smtp-Source: AGHT+IH61lE3K2Fe9bMptU65qQ5bSKC+NWM5L/H3ek6n1KHXY/vGtfhDxAqTVSPrx61q1nj+NCzpxg==
X-Received: by 2002:a17:907:3d8d:b0:ab6:ef33:402 with SMTP id a640c23a62f3a-ab6ef330424mr2468214666b.18.1738686644242;
        Tue, 04 Feb 2025 08:30:44 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6ff1bdbadsm762747266b.62.2025.02.04.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:30:43 -0800 (PST)
Message-ID: <c3f03a5837e191c5371593ac0a0e3c56e4204567.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>, David Arcari
 <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Len Brown
	 <lenb@kernel.org>, Prarit Bhargava <prarit@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 18:30:41 +0200
In-Reply-To: <CAJZ5v0hp8f3Xjb7bkDR_+RYfTE1ck=qop_QMZ3+z4w7T0VS66g@mail.gmail.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
	 <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
	 <CAJZ5v0hp8f3Xjb7bkDR_+RYfTE1ck=qop_QMZ3+z4w7T0VS66g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 16:21 +0100, Rafael J. Wysocki wrote:
> But it could be something like "prefer_acpi" as far as I'm concerned.

When I see "prefer_acpi", my intuition tells that it is just a preference:
"prefer ACPI, but may be native too". But I understood that the patch is ab=
out
"only ACPI and never native".

The reasons I suggested "no_native":
* Sort of consistent with "no_acpi"
* Suggests that native won't work.

Thanks.

