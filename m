Return-Path: <linux-pm+bounces-13385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F0D969660
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32319285B76
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333D20011F;
	Tue,  3 Sep 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPTLyNgY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B11CE6F5;
	Tue,  3 Sep 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350428; cv=none; b=odO911eBdzOPVixeCXMaxvr0Zp/uQbOSL7st19ACdqSQ3yf8awoQzgjCknwlzGZzI6VLwXDXLtfBVIEINRLRkKQ9vg4tSjDB3t4uyUQKezD0kG4BJdnd/DN42f4OhVKL1CVD8FgsNsZLOW9L6fce9ky46SZIBUFXlnIvn4bXJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350428; c=relaxed/simple;
	bh=mA70czq8ZW7v8o7kobVGuEeWJ9rCiSAnx+0VK13LKKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvSH0N2TdsAFvhBBNdMcJLCmabYZnReGkdFdMKLHEfQ2s2rMtbuGk6cuq0Zw81ic6kqsolV2OO1DaDL5iMeehkGOq0NGLjwxRAuPOzLLahNvtIS9Y9oXjxcjAQJOzcBJajwnpQyz577/HafPmLBlUWzw15sb1fh+cXrJj/v9VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPTLyNgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144ACC4CEC6;
	Tue,  3 Sep 2024 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725350428;
	bh=mA70czq8ZW7v8o7kobVGuEeWJ9rCiSAnx+0VK13LKKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPTLyNgYApP/rr4Cve02omhp0Nr3FodZpTuoMPWnSVmFClIYxZbSUSUONy3a9ivGB
	 FmYvpM2H9taVIQy+eXhd0PGFwZ+qztPr0bfJ4RFz7VELauvgOCNdCOqjoePWMl0KOS
	 q0nkXc3k8h32ovdmDZuqU/EtECbJ5Aq66ofO7Qt4=
Date: Tue, 3 Sep 2024 10:00:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yi'bin ding <yibin.ding01@gmail.com>
Cc: Yibin Ding <Yibin.Ding@unisoc.com>, djakov@kernel.org,
	rafael@kernel.org, niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH 1/2] interconnect: Add character pointer initialization
Message-ID: <2024090346-frame-scanner-8f61@gregkh>
References: <20240830102244.409058-1-Yibin.Ding@unisoc.com>
 <2024083004-laptop-outrank-9710@gregkh>
 <CAC6ZDY_V1w92gg=ZugbHhWfBJpVqNpuTdgvURk0WYVnzqMKkjA@mail.gmail.com>
 <2024090244-showpiece-backboned-4aa5@gregkh>
 <CAC6ZDY8KuBV5YDFJayCELkPEf6w_cMttEfa5fgQW85Zs9UnQtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC6ZDY8KuBV5YDFJayCELkPEf6w_cMttEfa5fgQW85Zs9UnQtQ@mail.gmail.com>

Again, please do not top-post, please fix your email client.

On Tue, Sep 03, 2024 at 03:23:13PM +0800, yi'bin ding wrote:
> Thanks in advance，
> 
> That happens if you write to the file, but what happens if you never write
> to the file?  What happens when you remove the driver/module,shouldn't you
> free the memory then as well?
> 
> answer:If no write operation is performed on the node, this part of the
> memory will not be released before shutdown. The initialization operation
> of this module is performed by the swapper process, so this part of the
> memory will be released when the swapper process is terminated during
> shutdown.

What "swapper process" are you talking about here?  Specifics please.

confused,

greg k-h

