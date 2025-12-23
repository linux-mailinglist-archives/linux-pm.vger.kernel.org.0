Return-Path: <linux-pm+bounces-39887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EDCDA243
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63AF13002B8C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A4D338595;
	Tue, 23 Dec 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="ruYLz2ZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077E29CB4D
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511688; cv=none; b=gH0wCTIvZUx2ssdcIo7/N0V53MKP8MbRJ7IrmYNPifjG9bp9cYwicfEiWhTtfrVb+DtG730HhBmnqHK0JmpQ66w2e68aFsf+XRTIvhTNEo+A03YiSMXuC67C9UkxgLcAuidTqqDwWvArS34L6AHuDvx4nkjfSrYGp01hKPzO1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511688; c=relaxed/simple;
	bh=4g6cRpSF90Sm8HT2nVak24i/3RDc2QDXNk1+OmWVOyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSHUiBFRbJKDUFsFmARKiPiV170FtRUPOqNMMNLkn0vGaezPuhZ78IG5LEW6iHnxFlb8fw3mg8RwcKB8SHAWqI0QvW23vlt8k0eVdjqTfpp+sYt+IHGQo44JlqZGGPYNzRpxa/H7Cgr8AgxgZgNQBB0CA07khs2In6sEXfHfMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=ruYLz2ZI; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so3776258fac.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1766511686; x=1767116486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4g6cRpSF90Sm8HT2nVak24i/3RDc2QDXNk1+OmWVOyU=;
        b=ruYLz2ZIevlheBvfv+g18A5vh8St/IDIDegOlLZrlR0TfsogTJrFZLVkZxXqRR66pr
         bet2B4WYJbZhoINe8ooHjb1N0IASQH6rlREr38ueC/wtgh/sFpmAIJqwIS5suF2kmhgr
         cJB1ejrjxImbn0v35qdyQ9s59tAnZff3d4WAMmNbuIwtGwj6dNKF7O9aTqq8HaFKa9J0
         C3easPuoFM1VS/7hXLBkcQXR+rikl4Cf1ra6shTQam6yxS3sSrXcsPXp42Nn8ZUxcEFZ
         redYlUY+3hKlAzF8gMoMVGBeAsO1g5BHhJctkzPpTEpudI3XMWGfdOcs+6cVvUxLj8vU
         4tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766511686; x=1767116486;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4g6cRpSF90Sm8HT2nVak24i/3RDc2QDXNk1+OmWVOyU=;
        b=YuWrTAGA1RB+L7hoB9PAlAlWvYGYm0Jr1UnqLkqnV9aoyPGaqV2moCo8yM2HEAS+Kf
         CsXjakaFycMlX7IOsvhFYAnFPcMOu7PhrCp0/WFe+c0YSSGmBcM3cl0Tg1oSM3YlkFLd
         TuBwCxkLEuySxfNRMdjjo6iAhiRJhpefZ87On/yYc1JceC7JmL8VTXpWJDb5ru0HEwxx
         feTATUBX+x7C7wvUEJ7RTlXTTSv2EZ/I+VD0OnEgQKn/ntk8eZTncEPqeLDr0RJ8PGuh
         WpKPY1uE122o8FaE1ZI3nd7rMQmQgCInirR4WRnOboYhyNsYmz3aVFywv0BrJ8oBaueF
         tS+g==
X-Forwarded-Encrypted: i=1; AJvYcCVqTM/sEXXweiLyQlDFlKLorR/WiZDJghLcXv34NMyUJSBe8zZiV47IhoqKQlZBFsfothjjxe9GrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15EeCbWRibzba6uDfWf3KOtKzL86J54n0Xgpfs3WwTSa6rQoM
	m/hwstwKB5TYD3DnrvLby1H5SwYIL2i5H5f98WIRhV9GJQlhnltDyYjkdtrlskuf1dD+c0umXMr
	c0ih9
X-Gm-Gg: AY/fxX7WLj9UkPNCZlNxiFQoXLyMAhYzvSkjZM0hrIvf407C/3K3vcqN9PX25PYyIS8
	2gV+mUKNnXKSpsuhkocCFRcV0qRmuC07BFTNZEZi7Gau38OHXGK5zLzjkkvuW+0KlGLcRO1OJig
	ar5qdaEGlQh4j304ApAMGjMEP2XaD8k6S1BHcJyMsyeyerjyxks/s6LSl724Uf3mbCKtMLUvbH1
	wOj+JRY5yDB46OxRujkeB0tm3gdIFAON2P4pADH+litofrhSuCr095TeFmJKtbbDs3Iy55ly9w3
	ucJCUJFkqeBmCdhFz8/fARMdZUAQ8LC4sW5PXfLO2t/QvffSHWWEeYKqOJgjeXXMPYe2zZLdcaz
	4Q/YIGYvh4KaayhXVEcJ/vVaX251dmewwReGyAVj+Z4f3OZxpUkzJb/mSt2nreFSjL/gt/mBo/d
	wQbYqz5K8=
X-Google-Smtp-Source: AGHT+IHvO/iSXTzXMcLwk1UZ6R+sF3sMQvret+M/zf3RXcZhjvO++LdF1822NYem8TQNIc1FlzGzmw==
X-Received: by 2002:a05:6871:2b1e:b0:3e8:8b6f:9d85 with SMTP id 586e51a60fabf-3fda585f9bbmr6902517fac.29.1766511686089;
        Tue, 23 Dec 2025 09:41:26 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf8f:aac:a6ef:c339:5c5a:a921])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaab65749sm8780158fac.11.2025.12.23.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:41:25 -0800 (PST)
Date: Tue, 23 Dec 2025 11:41:22 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, mmikowski@kfocus.org,
 rjw@rjwysocki.net
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251223114122.0227dab8@kf-m2g5>
In-Reply-To: <250bec4336d5e7adbc841e4945e50e589b10c375.camel@linux.intel.com>
References: <20251214184507.21f95134@kf-m2g5>
	<33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
	<20251215092525.6ea95739@kf-m2g5>
	<250bec4336d5e7adbc841e4945e50e589b10c375.camel@linux.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Dec 2025 05:33:08 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Hi Aaron,
>=20
> Tested on a platform with the similar CPU (100 MHz more max). There is
> no issue in max frequency or base frequency display.

Hi Srinivas,

Thanks for taking the time to look into this. For reference, the
X560WNR-G that we last reported has the INSYDE BIOS version
1.07.07S3min29. That might be useful when reaching out to Clevo.

Since we=E2=80=99ve seen this on hardware from Clevo, TongFang, and ASUS, w=
e=E2=80=99ll
want to report to all of them. Can you tell us what tool you are using
to measure the max and base frequency displays? Are both P and E cores
displaying the proper frequencies on your end? We can then share that
with the ODMs.

Thanks again,

--
Aaron

