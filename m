Return-Path: <linux-pm+bounces-18082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90429D8878
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889B916A8EF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB61B0F30;
	Mon, 25 Nov 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVvc/uzr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE71B0F0A;
	Mon, 25 Nov 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546226; cv=none; b=Za1nhDf88wi1rLEJu62x5eElT4C0Ea716e6fwEuSWadLliaO9FpbTSG7z7sTOwt1DZBcZ9Lrodl6lf8A8EhIZDzqZ5v7joKlahrx0RNN4bikRyMzyyDw50pgS7gVpXC5KqSXJljf4PwipMI7QDTObFOiSwmmaSc6Au/NpCyNL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546226; c=relaxed/simple;
	bh=99mQyA2qZ3XRSB0c6XpS7M79n2aRZycujApZ3uIkYpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsGeFDNr8jGLp1JWMEKKSNBjmVMlbV8uLbBYCsvIBeBEi8TAvy6JIbgtkXy9sX9Zwi1+u3b9Afw7+YQX7rZOR84L2SXhdPCBi9YBVw0pXgQA8Y/LAine9hacP8gL9CUu3jdG/tokEd6Zo0P5ASvQKcX/0df3TPiUl7IuGEyA608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVvc/uzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C9EC4CECF;
	Mon, 25 Nov 2024 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732546225;
	bh=99mQyA2qZ3XRSB0c6XpS7M79n2aRZycujApZ3uIkYpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PVvc/uzrJcxn7XmmAmYhT+t8FoE8vkid+dD4LCMv16oBRN1PnDuSx8volo+NYfYZa
	 2QUuID6aCy2mDnl1Kc5XEeQ1yogaHZ/ilhu/LUGy50Yfnran1CSPf4Rza3WOEClHrh
	 0voJDmtExgEU9Kmd3Zfifw8ddc3OfrPO0o4lJH+/1XEAPGQL4TGU1K1S/uL2L9BP8y
	 MYeyR2wDy9wV2XtzR8kRmdObOITn/czOynR//Yng0hF4SLx6bWpEMOYgA3XepkVsLV
	 R/J5q7XbElm9QV0zYalelFo/a+TaP6Ea+u9dcId1EaPnc2oROHixvaSsSiccBkFoQB
	 5EI3rdBHqW2CA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso3549249fac.1;
        Mon, 25 Nov 2024 06:50:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXISOtO775HryzyObbNSvO2DUXSoHJKsxvRdmNu+CcNU5Ep7Mka5jCZindMhY+ACN3+nGrcNZBWishadn4=@vger.kernel.org, AJvYcCXkNNkctlpHu4ZkbpYbxNgUUwYNcTyFJrCC3TzVcAEL9UYESxx3OYp5dtaIjJGz+20H/xCzO3fvHSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlqpR07FR4jc444v5+wM3+Ww14ikJD6MhR+l28Cg26yBnjD0K
	aXLWrlSHD92/JSl8NdxIvfMaadvtUl9rufEq3QwlXCU2eepdOaygcuH3N9xpWOEaALH8ZCm7SZs
	hEkufOI87PUsphbyCbJ9E6e2G1qk=
X-Google-Smtp-Source: AGHT+IGYGNkEgucZwRz7z466kKbcCeUbxNUCG+3UqQmFp2twNgsbi7teNi0n6xtFYw4fvYQBpTKht0RKHRj/OPxAsf4=
X-Received: by 2002:a05:6870:648a:b0:297:1d2a:a724 with SMTP id
 586e51a60fabf-29720b1f5c1mr9987946fac.1.1732546224858; Mon, 25 Nov 2024
 06:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com> <CAJZ5v0gpSCWMLxekbe2LWmfAxoJ3AzqLuJ7SAFp8+F1n1wUCtQ@mail.gmail.com>
 <9b38b1ff-1755-4648-ae2e-9c7cce94c2b1@linux.intel.com>
In-Reply-To: <9b38b1ff-1755-4648-ae2e-9c7cce94c2b1@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:50:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gKSBqQCV-zj7tNfv4pEHYp90bjXBn_EN_=Nxh=ok7snw@mail.gmail.com>
Message-ID: <CAJZ5v0gKSBqQCV-zj7tNfv4pEHYp90bjXBn_EN_=Nxh=ok7snw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for SRF
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 3:48=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> > Is this still the case with the latest firmware?
> >
> > If so, this could be the second patch in the series if [1-3/7] are drop=
ped.
> >
> > Otherwise, I don't think it is needed any more.
> I discussed this case with Artem or Len off-list, before.
> The idea is to add it for SRF too, to make sure that you get PC6, even on=
 old firmware.
>
> Just as reminder - the whole patch series is here to guard for future pla=
tforms too.

This actually is its main purpose.

> The SRF is just the one the problem was observed on.

So if you change intel_idle to provide :enter_dead() for all CPUs on
all platforms, the SRF-specific patch won't be necessary any more.

