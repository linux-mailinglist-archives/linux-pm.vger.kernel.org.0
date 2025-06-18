Return-Path: <linux-pm+bounces-28981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED9ADF00F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 16:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFCB1882B82
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC219D065;
	Wed, 18 Jun 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn2wm8rU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D4195FE8;
	Wed, 18 Jun 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258058; cv=none; b=bQvXKfHK0HVHeify9dRTvxyeiTx4+pRFq1Lp2L3cUvYYqw30cyHmwGdASAh2gk0BCjKLKHoPEMEXaLLkxEg5bPZBvzGVUujl/WJJCiVIQcs4BxQ3oQbE+RStWQ9vNrl6ZyN8YMO8p2mz4DCgB1du4rLCgb1SwRMBMwLlZUF5XsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258058; c=relaxed/simple;
	bh=P5bDzDbpwAt4NzAkEKVnGnsXVMLfR/Knkyugf6sSzUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDnYUK8pmQ1RGg5VTQvudzMssD9+wNfNbdlQbykJtYC3eDm6VBJa407zVxl+Wn9/lnswjU+54S9szWG3vVQ+FCtLnG8/N+EHKfJqDNgoYlpn1h0QtfytBBePRUNKqZhK/xJJPHmp+CgXKzPzJmiV+pqbMbNGpZoSd0dOTXXLCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn2wm8rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19305C4CEE7;
	Wed, 18 Jun 2025 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750258056;
	bh=P5bDzDbpwAt4NzAkEKVnGnsXVMLfR/Knkyugf6sSzUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kn2wm8rU+zYzOQFC3GPi8vOMZLlkcy3dQSrtT/k62GlC7Km+X00/m/imzVq7kwzyt
	 YCsAE52wLR6+AMSxzkC5oOUDTg2wVJrBzWxx+LWr5i6zyQJpkbAscZz+GLu7rhRf9j
	 Z7s0fW4uQbRXYb/c9zX475Wv1ZXwNkjNSuO467W8STZPTRVNfmNcH0nxpBpMnKFLkM
	 6VNjB8C7FXdlMZEY6sbm02XcqxvFLHIdiHZPnYIcIu5aQUvBDtR191jhYgJ1tFFOvT
	 BoKFjL6e28RacnkU1Z1Gfi4h3f6LmSaIVBzDUFUHBo3QoX71d5n0TdfUez0GLtopT4
	 dHOfLvT5drktQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40aa971550aso418806b6e.3;
        Wed, 18 Jun 2025 07:47:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiOuuNcOsDpJ/B2C498+S16nj+GT7H1sCSpcabFbvvCsvmLPJNe+YeKs8YCCgStMTEUuImANj07Jc=@vger.kernel.org, AJvYcCXuF7wL4NS4LdLP5P8292UPkgzXZbQ/Ti5sOrCNXhcmWqR4T8tYCepFIPAI8McHond5vJaMEqFl6PwkILA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdhu4K4ABbLj4h382Pg52GPR6GnPtSCPOKdgK3+/VIUGlzgFe
	aAgYx9DBY4PDx85/0+g8j9ojBCIZtWVzzqRFE74GGp4CO7robIA/GLsvUqavf4vUYVY5wkhy0qw
	G+p72eiLdjQhs60BwBk/ZW+oW+rVeimc=
X-Google-Smtp-Source: AGHT+IG0KvkrWiC9/BMAK+ZcE0na5dkQbBL+doJY3+FOLWYOAeu112Tto95wPCxnsBx0AhjSVQP/qcAZcap8GwiU6nw=
X-Received: by 2002:a05:6871:5b20:b0:2c2:4090:9e8 with SMTP id
 586e51a60fabf-2eaf0a1d13dmr9762977fac.22.1750258055473; Wed, 18 Jun 2025
 07:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617124900.186591-1-rui.zhang@intel.com>
In-Reply-To: <20250617124900.186591-1-rui.zhang@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 18 Jun 2025 10:47:24 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmnz6=ixNNYy2-h9P1=Vyr6pDPz_0d0eHGLU912ozkekg@mail.gmail.com>
X-Gm-Features: AX0GCFtO7pIu6ihX4dGg1XHKzL3Y34AHRQgcdC4TK03zajTXI1Av07JcwCcV8hg
Message-ID: <CAJvTdKmnz6=ixNNYy2-h9P1=Vyr6pDPz_0d0eHGLU912ozkekg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/power turbostat: Fix bogus SysWatt for forked program
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applied

thanks!
-Len

