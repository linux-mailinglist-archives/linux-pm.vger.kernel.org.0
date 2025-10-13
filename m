Return-Path: <linux-pm+bounces-36005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC58BD63B8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8255818866F1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69F2EE268;
	Mon, 13 Oct 2025 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvAVBQqs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3452D47E4
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388365; cv=none; b=k4O+DKGTiWmUUqjc4joy0y3UG21Hcqmu+Ukfc0aw9Dgo5V54sTcbcXdW1odAHa3QBnIkCnq8yIRE/WAt+Fhj45V5BMQydziEg8QnX6/R2mfkM+NhVq0VaDHqmWSHOQzWZ6V7cAyuXq13stQmPq7hLJFdF8e3hDPrWp7mhB+wpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388365; c=relaxed/simple;
	bh=99QjUoMLoVQrhY3mrpehmIsZka20aMAz1lwH7oyNwYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV8XsKTMcCLIC8tiePtGI7xgwgx8WUtDnUT7dpyof2M980CIqUlb0nlDB+3XmcMBX4qN/zQGpBpMJe44XvDaBFxzhcpnNYd7rTzl9tMdy4tXGhWE+El9c4M1ZsP+eaQVE7+yWtKvJcusHyJaOvAUl3mjC+/4iNqjMs1kFxSixKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvAVBQqs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so2137084f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760388362; x=1760993162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99QjUoMLoVQrhY3mrpehmIsZka20aMAz1lwH7oyNwYw=;
        b=wvAVBQqsbnTT+WQ5q1j+wr4/lzjUSLc5g7rQSEGuDNyJfzOLoVyRb2XI16zXEPFpXy
         +7S0L6Du7zvvISBuz7nuDsZMLlw8a9W0vvOpib1w22wjJML1ckNOzwI35p9P4pYG+Tf8
         q2YDy+mzta+G3RpYdmvwGzgVZqCr+yslcCMONFq+V0+nmMFDZZ/eGaKblLBhNO+W9QlS
         6Hvj5XVBX2bPv0fU/wb1gJeO3z7B9KvV+rL8JVurZfmk8AYrSPtm1LOr+k7oFXWy4W6q
         VoVKp5seCOSr/acE4y9cQmhjeqQji/kZk5602k0lEfN4Muc1GAWDdoGAkMfYuIVTwBI9
         OWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388362; x=1760993162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99QjUoMLoVQrhY3mrpehmIsZka20aMAz1lwH7oyNwYw=;
        b=JcDT/PdPqm+2SyzDV0L7mlttfhieI2L0hD2ESXSnHnP1rfyQtJkig0VcwyJsGFC5wd
         kEDrGmCHrZAiEVjXYn/PMYLS8jpdvBz899cVoDtWTBDsBPIQDvEpf0Bsrzvu2ILDPl5A
         +OQUZ3Nvd8QHf0ixuRNq4/7mjXbZgob52rKzPLFiddUrDi3Mha/VsSGWpOP4bsBUlxx4
         liVU+KhIyVM+W8F5uEpiT1gXIBCSDXMBVaCqNbmWi5w71j8naHWDUH3QQrb0Ca+a9Lfe
         hd++4qFPsdI/qTdxfjEHxY59Cwl49mThQUnIbZnFKoq7FWdMrMR7EMrAdTOv9zEiN+zH
         2Fmg==
X-Forwarded-Encrypted: i=1; AJvYcCUbDXzBt9ggjykHEJ0zYnG/X1pNJxTX+iTbZvCxlkFYdWl6J/tzX7mXK7zCj7adGSXiA8vbU+kAoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKZTnnvIcF4PI/yhJFxQIw2GFzfEVRzQvbk1gGFccE/AP3Ayt
	b118KKel5dSjRpDYcdWJzZwmFHdMNcyHYgayEz+IVnyYAoQJNxWpVi2Yrlhw9+olYzDqHycH+4a
	w1aMN1ptl9+FFuvMB3jnIbgXkLxvjgA0sL8yMSbhk
X-Gm-Gg: ASbGncuXwVElioxmm99i7dR4JpLrO50wv6/YOqvuTmu/ItZ5sKCJkBqcKfYeBIXzpwR
	c0EVBsS9wYKOTGrOULVrm+dAGTMEwKrn/Pdvs3v6b0gbYwOzaKI4DpX3OM4QICi+jCdXSBEwyK1
	uY+cPA46zR40Z6tpoCqeeYfCTNfnFXeBHI/mbjG5rcQbRLkSgDYlKZwxO4PNviXJkQsmxwW8Osc
	fdvIYNLEcMhawASp0yVhnEciTPN+m8Fu2FtJQrDRFoU5SCktE47poxjHGAJYESNzze3V7s7hQ==
X-Google-Smtp-Source: AGHT+IE8TROKuhNVu/BWqODTDcSV9rDf2MBMkLJcEl030I+lvoxpeDpI1cmeAFlCMdh9HW11ihmrMXGez5UzLgpHrN0=
X-Received: by 2002:a05:6000:491a:b0:426:d53b:4ac with SMTP id
 ffacd0b85a97d-426d53b05admr7436865f8f.36.1760388361662; Mon, 13 Oct 2025
 13:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <20251007000007.3724229-5-jthies@google.com>
 <aOZhyhmIv_d_knXK@kuha.fi.intel.com>
In-Reply-To: <aOZhyhmIv_d_knXK@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:45:49 -0700
X-Gm-Features: AS18NWChD4MSZ1x95bfLrGIqzvRKmQSlLAN19rWkyqbygoElJEKAFbCC0PRVrEQ
Message-ID: <CAMFSARctns_u+65pWH8+j65bv74hKcqFBgbZzCEH2PO+PQ5+SA@mail.gmail.com>
Subject: Re: [PATCH 4/6] usb: typec: ucsi: Report power supply change on sink
 path change
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> How about:
>
> if (change & (UCSI_CONSTAT_BC_CHANGE | UCSI_CONSTAT_SINK_PATH_CHANGE))

Thank you for the suggestion, this is neater. I'll apply it to the v2 series.

