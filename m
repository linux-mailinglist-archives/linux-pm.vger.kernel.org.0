Return-Path: <linux-pm+bounces-35604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE32BAE59E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E842C1925C2A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89823B63F;
	Tue, 30 Sep 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7iKkPu5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1A2367AE
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258276; cv=none; b=lDPO8nFwivU91RRF1o8j45tAqVT8kY2OnmK6KWGcjdtUI+3WwM1eGv2mu/Zwo+F36aPVBOedtTFL+RBgu3+4AKJavFW+xy6KXFk6808ZCKLMdMVjVpOlj1ztgVkaXmvu419JkQUe9YNqRBjOWZILRbC0K2jt0BOJEsQhOD74J6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258276; c=relaxed/simple;
	bh=NkdExUDpclA9Fg1j3ie4bd2VCi/HCCplrTLy2aiSZLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uD41leZVeU5QX7m2gCGrrVnqGe95ucf2+hpXq6SfNxXP9VBRwDTWlxxEsI0zO5h57ghqPXVH6QSXLOUiQQduBSaop+MUPSKD5yXy0ifOidGyMZDCjGT6Lre0z6Ljnhw98hJWbTK5nrDlJA7xGdLOonKEi69HigbhZbdPDRnY7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7iKkPu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EC8C116C6
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759258275;
	bh=NkdExUDpclA9Fg1j3ie4bd2VCi/HCCplrTLy2aiSZLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q7iKkPu50hNbkUDogg3RJskl7MACLFQ8fITLCjWPhjLiroKM8MDmzRJwUOc1pp3yG
	 gaZdyum4hsslerIN9aaax51CsDDGGLNx7BapMVH6QkxqFwh1mHPIJ+FuMPpoDKXMMe
	 uOtP69lkwAa7C35SRmF8RQhhWcvxH/QbcYAzSu+xOOv+UIZbaWGYlDeibyNluhTbVB
	 oWQJtXQ3NF+tMrEvkgmDAGszigPjOsRdjxLAchszCdGAgZUMdbQ7YXnuRwwfS1kqsg
	 bAAczOFLYb+hKScRWLbARVKKMdJApmX4qV6UY4L11BnA57tU9taI8fk2Yt3A3dqCSq
	 KVHMDVCBtJALg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-378aa12c13dso1702112fac.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 11:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyi6oM/aiEhxAvIONg7vkyuOYNm8auNWcQ8/jir3ByjtIbzWtYIGecitbkTYQm3mkunoFegphvTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tldiyBGHaYntygiRlHq0SMAoCLW/K1TqW+GvHV/xHsBwMs0c
	GLMdColhxLc0UlAJm1JTwvYIIwZCDelmi0IPSqvVEf5T3fqFURqH01nrgqyaaCcvsPKGr4Q3b66
	M77AETHuQ1JYAkSv6og/CL+914wX6KVE=
X-Google-Smtp-Source: AGHT+IHpwNExFFDtWEPob+ylg8ChOuJAJQOqjyVUIqZfNwBfVZG3J5T/+wZS/dHPSnGof+tKgHG6b5fH5r7L5eR7wzY=
X-Received: by 2002:a05:6871:413:b0:348:d760:6f0 with SMTP id
 586e51a60fabf-39b8da102a8mr359360fac.1.1759258274674; Tue, 30 Sep 2025
 11:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
In-Reply-To: <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Sep 2025 20:51:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
X-Gm-Features: AS18NWD6F9iwfrH1Y-SaBpL35fP4wctfhIpjzLztZAL1rbnXrUfdfiLbRlkSVt0
Message-ID: <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> Hi Rafael,
>
> Just a friendly ping on this patch. Please let me know if there's any
> feedback or if you'd like me to make any changes.

Have you seen https://lore.kernel.org/all/20250909065836.32534-1-tuhaowen@u=
niontech.com/
?

If so, what do you think about it?

If not, please see it.

Thanks!

