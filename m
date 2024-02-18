Return-Path: <linux-pm+bounces-4041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D148595E4
	for <lists+linux-pm@lfdr.de>; Sun, 18 Feb 2024 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD0C1C2137D
	for <lists+linux-pm@lfdr.de>; Sun, 18 Feb 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0AE107AA;
	Sun, 18 Feb 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfENhN4+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB3EAFC
	for <linux-pm@vger.kernel.org>; Sun, 18 Feb 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247221; cv=none; b=UBJXtr6fm5ZDt1lev55uqXsgNTntbawetO1BTzpTchJycoRYgyD+YwpF1hjIwIH2NCt1C3Ty9d248OXHtejb+j3rGT5t+KPtW3zB+0OOwBcZCiJEEOikxYb3iA2V+ZWfqyfRtPGBovHcLCMYKFpQHMOo0hwbFnxM+OYea+2nsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247221; c=relaxed/simple;
	bh=HFou+Ynhj8r45qIYynVJq3BPxFIXGbuKAoHIGhaH17M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCS94IVQwQ1f5AOzhQKdgAHMh32ai8XLmDn9uAaDUetLUail8v+/kV3J+fHY/HZA2GAixvJFkkrx4CrVNZuGkrjIpU1f5DEksZL6HSsCNcHEI5/Ti9TL2Mc50H3V6p442xEOBNgdUao3VrXgGnyZZMeKp0HtTPP2u679jbSNqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CfENhN4+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1476916a12.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Feb 2024 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708247220; x=1708852020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pYjP8Elq30R0i6ycDkBbNUM938GG/2nOBO34J/gBts=;
        b=CfENhN4+7of4UE9gjPzdZOhi2bMwCVSCAGl3GBKhH6SFsZ3u62gWEJ7wMEaKRfaDW6
         wphwf1ieqcQmWlzhDt2mCiOwZEouB3WdlTyC+jmN+megcEs8dqAltFuoBSrzJr2MXp1n
         G2xrB4mxSKP68DMz3akurQweDLE3bw8eeVlwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708247220; x=1708852020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pYjP8Elq30R0i6ycDkBbNUM938GG/2nOBO34J/gBts=;
        b=XmKSQT+QmOqsZZfkndoQtPEVts0JRVaQx2JMDRz7wjA8BozKvLrJeWfrF9qwTGu251
         6o/OfsBQ60t3oVUTOGlEGa+56N8lHqlAORqHK2K9fRPA3eMLRtPeS4r918eD+19Qj8/W
         LhFn9QGBJ+G1Yw4Lku7kfnZd0Egh3gTp+WoA/gVkyMuT8L1MSNDsFY+Va6Mzqg9IaEQH
         IVgOzg9iivB5tayzubthaTImpRTbaJ+LLKNDrCQkK8ER4OfALdj1G8NEkKBJcD/C2yu3
         CXKwm5fH62BBgLAfVi32MKUjabZkQWBOVEi2IIYZSRkNm2957iiUFHuyt1ADHcdWQpB/
         E8rA==
X-Forwarded-Encrypted: i=1; AJvYcCV87kltQMws3zDlclriyoMIEE7nPxtUznEPKiWEgk+bQLlfl/hFsOcy4oWpb56n/d15dX+fF00D2VP1OJyfV/XFFH3F/wfwhAA=
X-Gm-Message-State: AOJu0Yw9CEoe2ouWWHepg0hBViP6KV5R5v6LDGrfP0OECJvy4xu9JiKa
	I97B9ZO2cP7/bJKiWgUlaH56Y5fdMEB9BMKHJsotUJZJEhNnzNbyo3ZIPWo2NA==
X-Google-Smtp-Source: AGHT+IHE3MbZ/4iRpYOBLF5b91QTfJN5jdx5IDOudYN6UjSGzsBL2ieEcjeoydWDpFek6WFz9QfxRg==
X-Received: by 2002:a62:cec9:0:b0:6e4:1a29:732f with SMTP id y192-20020a62cec9000000b006e41a29732fmr991819pfg.12.1708247219780;
        Sun, 18 Feb 2024 01:06:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c18-20020aa78812000000b006e1464e71f9sm495605pfo.47.2024.02.18.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 01:06:59 -0800 (PST)
Date: Sun, 18 Feb 2024 01:06:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: Don't ignore return from set_memory_ro()
Message-ID: <202402180106.25E08136F5@keescook>
References: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 09:40:58AM +0100, Christophe Leroy wrote:
> set_memory_ro() and set_memory_rw() can fail, leaving memory
> unprotected.
> 
> Take the returned value into account and abort in case of
> failure.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

More set_memory* consumers! :) Error paths look good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

