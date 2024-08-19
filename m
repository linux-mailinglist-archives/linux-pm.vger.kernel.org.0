Return-Path: <linux-pm+bounces-12415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3849567E0
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C411C21AF9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81315F3F8;
	Mon, 19 Aug 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmR8pEPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27C15F3ED
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062361; cv=none; b=HsSDCy43+D/Ll3vuwvTMk2uSFTosweuL7xrf2/ffnKjkktQpxbqq8lsT3Uy3IJoIR6Y26lUXjbv+9XNu13JsmiblszkaRIoGpgARzZEpsRcEWzGm8eblG1N/QBZp5fhdlUdUFi03O707r7dxVNAxUQQ/VkHK5Oyba9hr8BAmugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062361; c=relaxed/simple;
	bh=vZo2/t11CLRtBFZBAyg1Zxki1cpdcGREz6Qnn+hDfcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEIcN7dF9/HywM3Afh/nGVVEu/E1VIsydTYazDMYj0GRrR66/ecj2eKVSKFARAxUH5soGvBWfcEuE8+XDVP9rRYK//4SssoRkIqWOV0GXd/073RAQwwPcsUlVmO2oBoA7uBShLyHBi2WWtlCuUe5f5EaDPaVhv44YqnYctDVp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmR8pEPU; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6e36ea1ebso1386006e0c.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724062358; x=1724667158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kEt0b7cjq1QrC31R8bsvHblz1HFMuMei5OYtb8lQy+o=;
        b=BmR8pEPU1VaogzGC6Z/pQ6JpGZ9grHlNGOh48Ws5+Cs45ynNNrPLJfDjNt8co34Uh5
         FslywdTU02UImtBCBv8kNDr6bJd2jda48BPHpz4ribqqZ/9XMcwoX69WmU468mql7GIe
         GZzb716s7J6VDricJch7X5gYOqLirnirpX7MtfmjCICxOUR5rmYuwdbdlTibKTb0z10X
         uzgSJrF8W2+Rs5fwuMD8k2g/nPyminamEOiH2zuH8dzZEKjCyJLRQKGSEy52NXmhU2iA
         imfyHDUnhoOohxwOJbojOHI8JEWKQ7dcxfS43duPAn1v4KANgblHtPxODU6RZturkAwG
         mhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062358; x=1724667158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEt0b7cjq1QrC31R8bsvHblz1HFMuMei5OYtb8lQy+o=;
        b=jETaVcVcHhjR8ONUDUzPPe0Fo4kd8lvH/NY+HGavZ6zvDgCsQk1UyeLzSdrHYpmiDv
         sJ7JES0awq1QD6Rnvq7sXk6jEjhOL/FGEcJ233+uTtsBdDJhzr2m/t+uLYLwpyYkYDwr
         0taSXu0/qedIhhFqYhWYN7sARYBA9iFTyhxg1sv4yppfh7ix5MYkguJ8KTeqIJ6y1XNn
         3L59FEF1Sk4iCWHogBOUt+MMPbUnPFkbwwWt4KsFfdt18yfiiLRViIKOowgBefJI1L6l
         jCKmVmIiee4zEVqensP2RXbvjyo+Oe6nPIztVoLci0xympv5e0MEusX5MHXuZ/wTPAo0
         /9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVzv8DUDVOyiVhngt2SLxthL9lrLSJN1oL24zXzYURaehlNRC3pwgxi+Pe+TDdxrGZm0pzU6JbPSMnwNcM/41ecntVekpKDx70=
X-Gm-Message-State: AOJu0YwfA4ptrJsHelj6MlvVAc0GYyhALL6gcyPFO9apAThyruJvzi+U
	Dmnnoa3vvaRQD6BunBI2ntwB2hCy+AHe1pugXlfynNwmI+VXcAt5ZjLKEVI86HPl5dQgcSyLDWU
	lbPlQKbM3PoW/g+KB/soSoAEyFV/R5sgpdYn4yA==
X-Google-Smtp-Source: AGHT+IF2X6KST38O2iXNOkEv4ma2f5ghfmUPtcGSPzix+b5Pd5uLiS8hzIqnRvab+YafaLZfxCL8wAqGZ+nvTGAWzos=
X-Received: by 2002:a05:6122:4129:b0:4ef:5744:46a with SMTP id
 71dfb90a1353d-4fc84ad5a54mr8021886e0c.1.1724062358099; Mon, 19 Aug 2024
 03:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 19 Aug 2024 15:42:02 +0530
Message-ID: <CAMi1Hd29PWjsS_kxPpFgpW23xpSq6n6uqL5KKFBvQwe7df0W-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Chris Lew <quic_clew@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 04:47, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Amit and Johan both reported a NULL pointer dereference in the
> pmic_glink client code during initialization, and Stephen Boyd pointed
> out the problem (race condition).
>
> While investigating, and writing the fix, I noticed that
> ucsi_unregister() is called in atomic context but tries to sleep, and I
> also noticed that the condition for when to inform the pmic_glink client
> drivers when the remote has gone down is just wrong.
>
> So, let's fix all three.
>
> As mentioned in the commit message for the UCSI fix, I have a series in
> the works that makes the GLINK callback happen in a sleepable context,
> which would remove the need for the clients list to be protected by a
> spinlock, and removing the work scheduling. This is however not -rc
> material...
>
> In addition to the NULL pointer dereference, there is the -ECANCELED
> issue reported here:
> https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> I have not yet been able to either reproduce this or convince myself
> that this is the same issue.
>

Thank you for the fixes Bjorn. I'm not able to reproduce that
pmic_glink kernel panic on SM8550-HDK anymore.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Bjorn Andersson (3):
>       soc: qcom: pmic_glink: Fix race during initialization
>       usb: typec: ucsi: Move unregister out of atomic section
>       soc: qcom: pmic_glink: Actually communicate with remote goes down
>
>  drivers/power/supply/qcom_battmgr.c   | 16 ++++++++-----
>  drivers/soc/qcom/pmic_glink.c         | 40 +++++++++++++++++++++----------
>  drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++-----
>  drivers/usb/typec/ucsi/ucsi_glink.c   | 44 ++++++++++++++++++++++++++---------
>  include/linux/soc/qcom/pmic_glink.h   | 11 +++++----
>  5 files changed, 88 insertions(+), 40 deletions(-)
> ---
> base-commit: 296c871d2904cff2b4742702ef94512ab467a8e3
> change-id: 20240818-pmic-glink-v6-11-races-363f5964c339
>
> Best regards,
> --
> Bjorn Andersson <quic_bjorande@quicinc.com>
>

