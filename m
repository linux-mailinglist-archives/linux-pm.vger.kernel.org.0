Return-Path: <linux-pm+bounces-8056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9908CC63B
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 20:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0826A282015
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80321145B10;
	Wed, 22 May 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fb4K7RV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB6762FF
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402151; cv=none; b=X8rz2WXd48GUObGVHPnYCAOSfx3iMDwMvHZU5lzpeoN0mibPtparf3Jw6dPKKwujtCglnF9eohtaqVKBYTOb2HbCG6xU3Jp2sQm1cvCCMmIE6LH/ZVCPtsJqnjXcao1IDV0VR4bJ+Colhb8VgL/LhZ59wYc6G3ydVEbztELRV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402151; c=relaxed/simple;
	bh=ZFK6u4Fa5zvVRsR5pPiIVXF/YDHCjWe6si/6yyn/Lng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/yE6SBmaE3ZmDohv91Ni6dTg8pb8s1Iru9ABliiVfo2dwcL2RTnxdvgthGIvOdlchZvu0pc8npxB9Bf553HjkqTLV1vpwUR8/xqBUSFOXkFQLkGJQW11O28HZRMqPtWA4aYs5DR1OzFhKTl9VTU7pvdk4God4lfEVFb2x3A88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fb4K7RV+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso11150375e9.0
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716402148; x=1717006948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFK6u4Fa5zvVRsR5pPiIVXF/YDHCjWe6si/6yyn/Lng=;
        b=Fb4K7RV+rhQPofbyviCdQE6SPCroqZr/XDfiRJizjk4YH7xicEC/5G4QpWG4JC+Elh
         GMv89EQyom+0El0f1+g9UKgJAfmQ2Za5RIMvwUP4Vkc0KJ3ZvuNDAopHpAldIH/3AZnK
         GQTLeyTonh696l2/o983ZiIFISQXgojSzGAtL1U4fCKwku9S/aOU2GEEw1wL6hOKJkJV
         CY+mo2oRPnxzBcDY4c0b/yw+tF73CJbMrnqCzsvGl3l+I3RcsV0RbpvVl4b7NkD9y9y2
         KFjWhBGXOIWhTQbcid0TwXIFf8r6Us06APki1LiWw8BVmNI4uCIhwQmBrMeH0zB9tSs6
         r/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402148; x=1717006948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFK6u4Fa5zvVRsR5pPiIVXF/YDHCjWe6si/6yyn/Lng=;
        b=es9vLj1hTaMWOx77TqGeop2mUHg2rz7DTOPl0mDF9AJeYwfTxpACCFgQT812KaUVnQ
         p3023YrlFEYbcpUDNY1leAIr2CLYt40gJ3Y72E15RLu3LM+4/YSZC1MxXUfQcM+b1fo2
         lPR9ft4Qne6bWjMk/FIaribQ0ptY30vpoCfF1vXy+cwM7cgV6fKA+I+GgyFjsNyLAP0q
         zONrpKOknw3xF28wtBnpMRhqzjlHrORFVsGFT/87mQGep3LTTy9UUeXNJEGRMnjfcR2s
         uWSxc+HuRBAL7jbUtvoblFc9sppNKPD/0HRRnpdoHppuokcAXbt36tIrQ8ruzaImDlX0
         rbTg==
X-Forwarded-Encrypted: i=1; AJvYcCXYp5U/59oz01jWj57JKpqvryX7zHCJ2Q/99Rm3iczCoYb2bkNOW8+B12TBnEm+VEoQQo0srv62/ddO+s0PVgnGHmE9HGHYc3U=
X-Gm-Message-State: AOJu0YxXNbOELYkWLSbfBKBWFmssi9orzLVe87MOtoUmiZXNCzs9ouR0
	vG5nnJW87r05dyJxjH+4DH6NVeRmmJZXrTcPr2fXAsMxyMTTggAA57/iLfzSaNF1GeQGWrhV1Qc
	dfOx4mY2W9Tjw0qP6LELp4AOeGlB6PtN+wMdZ
X-Google-Smtp-Source: AGHT+IEqHrhvngq0QbJdNPXcNp4cNgyuDl9fbQnATErpVY20xw7tN2DbVz6qiqx0xfhTGgjKnsrIXyee4iHwgZnXnsI=
X-Received: by 2002:a5d:6903:0:b0:354:c934:efa0 with SMTP id
 ffacd0b85a97d-354d8d85254mr2020590f8f.48.1716402147986; Wed, 22 May 2024
 11:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521043102.2786284-1-davidai@google.com> <20240521074137.eip3jcnu6yhryrgq@vireshk-i7>
In-Reply-To: <20240521074137.eip3jcnu6yhryrgq@vireshk-i7>
From: David Dai <davidai@google.com>
Date: Wed, 22 May 2024 11:22:16 -0700
Message-ID: <CABN1KC+pGd2zev+mkzavpHNV5P1A8gPEPKgvKocB+dzEyKyniA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Improve VM CPUfreq and task placement behavior
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Saravana Kannan <saravanak@google.com>, 
	Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, May 21, 2024 at 12:41=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 20-05-24, 21:30, David Dai wrote:
> > v5 -> v6:
> > -Updated driver to use .target instead of .target_index
>
> May have missed the discussion, but why is this done ?

Since the driver now queries the device for frequency info, the
interface allows for the VMM(Virtual Machine Manager) to optionally
use tables depending on the use case. Target is used in the driver to
support both configurations where either the table is used or if only
max_perf is used(where the guest can vote from [1-max_perf]).

Thanks,
David
>
> --
> viresh

