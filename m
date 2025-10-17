Return-Path: <linux-pm+bounces-36370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD77BEB5FD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C264319A57A2
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A82E8B81;
	Fri, 17 Oct 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jN2bXa+Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42223184A
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728808; cv=none; b=Me11mzCGXFbfCYtlBL/1fc0aNoeeb46lunqraGrdFgbkOymksRIsDgcSVGWMcxCRsbP+JB458bnGXrmOx+RthIas7kDoxIAwNrYRER7+4az3r8exlK5XDgrupzPgujdBufmIpJHwuTL0uBrayFbhnfE8xlnzBicMAU4eE6H6AXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728808; c=relaxed/simple;
	bh=dQc0lw1C6VoW7QAgpMjyWsMfikVa/Qn+q5wJUy/awm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fupJOUD9lkXmpPQuj4sqcs8BpAxTJAXFcLdS692/opYvRGjmAfuYTl9vAT2FoY3CkZ+ktiXEwGvr0lsi3jXMbZZ+fkUhpRQcb/4jDFRNUG5bvM9QCrB7lCBpL7y9Qwb6XL0COKTWwob9M3AVRPQRU2ZqDA+ngB5wsIFYcNhLaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jN2bXa+Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290d14e5c9aso15581315ad.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760728804; x=1761333604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHXngnuNlh6itPj8r7imVgK8MxU3nTSTL/IVvz/XXP8=;
        b=jN2bXa+Q2x7zSjnPgGSv1JJ+CmfYRgTXZk0b36p96awMRMI5WYzIoTOM3jMs66DfD5
         lvk8d34iHxWZ0zwAioU4VhSsA0jS1Oku5Ij5PXkMqe4gbRj9LY/ydu9sJeo6DT+RKTwK
         r9ZypfgoLOjJpvb3Z9PlwdG2pN3qtbD+13jbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728804; x=1761333604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHXngnuNlh6itPj8r7imVgK8MxU3nTSTL/IVvz/XXP8=;
        b=cOZD+jbIDGV9Ha341ZTKPY+zj8lOV+reBYXzk2vz6dlnIjwPcR0DP/cYsPauNGSI8i
         Fu0UpwsIRpfewL9fJCbdyu1JlroJbuae8KyQQs2ij3Nnqb6S8Ld2OYq9olmw4gSS/xKu
         2mASlTOQCoAxytuGDAYpQbxka8BCuONkw5ipI6oRSrG7cVJ4exoL94NoXvj7LfGnsZGU
         lyq1r0Wf+XAZa1Mo/sTghU6vpmo+kEAVu3ThcWdzZbji01hwveibxF09BITTfq6yir2F
         e4vKPb5kVRk9Cms06yscS4ydsH3CpOFo0xepHmQcFslNx/mmyURz+9GfTm3TEwPNRNVV
         My+A==
X-Forwarded-Encrypted: i=1; AJvYcCVj65BRvoKr0vOll4Uo0k+QoF4WWljZX5mKExVn8F9GVoSm8VnHd2wSGOWeWo22DJUXhKgYdlrUjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzmiF/ezoYmyBuwic3S4xrkME9mPqqNZJTmbAjngOvhWF29hW
	YWUItJ37ZyxYByM6gfzq8NW+9ZMdVpuaCRS5Bp4DFajijr8h60fOJv0tK1chEmjmEQ==
X-Gm-Gg: ASbGncue7H8OBfaCUQjd0t5jL5jatWmkJn+2TGbLFeK3TX16KdgDunfdva8p4ENHnGe
	FwLTGMMbt7ug0zVCzdE1xlH67h/I/GM1MGCPO02Sy0WIlvEzM+KB2LrfalQL6GYw+54yOi4BS3B
	tBsmQ9Hx4bxqD4gQRNkz7PtTaa4Vt3zjLrCZZxQ5Yx7T7DbRD1L1CyOjWWCGnrMKfho10i8QhkC
	9LemfcEUuUAO/olxDeMJyIRlw7rvDlclsRu5bTS3wgtwlISsB69FhFCyGN5VSo2ko6/hNUB67Pr
	qgCaMQUcV2dqcHr2anwIhkQI0Cdi8w26AeHYb75FN62OE/uYSPTiJKGXV1ioF51p8scgoy4oY7J
	bnrN7DzqG2WdNhzLSbibVcN3K2xlfiDsjXPALZ32mNAUCC/CoWdVHX+NxvgCv7cacnv4VdReqV2
	BTUVCa2kTRtSQLxyXD0Gz6mCaNcOFe8Y9ymQ+af0O9BxEN89rn
X-Google-Smtp-Source: AGHT+IElkrHhhyNLeAZol7uw4OirIzBxUzQlJYrmC4LJFvDksofq8jEPQXbrqyZan9Zi/uQsogvSNQ==
X-Received: by 2002:a17:902:ce87:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-290c9cbc92amr70205745ad.19.1760728804005;
        Fri, 17 Oct 2025 12:20:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292471fdce3sm2636175ad.90.2025.10.17.12.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:20:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:20:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPKW4nXfQxl6SmLE@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKANja_k1gogTAU@google.com>

On Fri, Oct 17, 2025 at 10:43:18AM -0700, Brian Norris wrote:
> git-send-email has --suppress-cc, and maybe I can convince my tools to
> do that. (e.g., `git config sendemail.suppresscc cc`)

For the record, that'd actually be:

  git config sendemail.suppressCc bodycc

I think I'll use that, since I usually track intentional Cc's with other
metadata, not (just) body-trailer "Cc:" lines.

Brian

