Return-Path: <linux-pm+bounces-12549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB57958251
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E539F282191
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A118C034;
	Tue, 20 Aug 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJWn5lMh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1518C009
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146470; cv=none; b=PcXAGj8ogopgNmXb6SIHAg7rgU3G1nxOHWywHjUwrNINBYY2d9snWkaeqH5JoHrxAMSOndf60QHJ160bXB5Xp/XuiNnaR/EIjo130YkgZzSEuu/ULginlRJLfDXC+FhOFbvNtoWPva/TEVwcyTOUikdfTHvMy7XtHdKPf/aW2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146470; c=relaxed/simple;
	bh=lpwvR8JQmbQEFx0za9ze36QvN/IqXjBZdApqPmBrnLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHno6g39E9h0m8pM/bNhT8TNLB39teQAs5XY49acckno/KtihmnjrQYy80ROQsZr2mzSdVninG4cHpDGDGHWb2PsFiuTRsfV5BWYGVzkolW/mNaqnSBxCUaED76hudOTZGsRDHMIloSdQCsmM+YenYda1AbSIMdkimUC+WK4Q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJWn5lMh; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e115ef5740dso5589864276.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146467; x=1724751267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0N19Vu1+Qd03nSpC5/+nmku5ZBvJyZkB8ae+csSMnuA=;
        b=vJWn5lMh1ajdhWwSDfV/jdcwjl5xjr+6MDsDDYSJvmmquvdj7I25hkdQlv6aYelo6N
         CnU8pBTMsLli42zgWlTu6vtjtqTn6H7J+Ol7uQ6MLlQE1S8f5JjZ+vO9OU3tmPTx6OMw
         7VuOQL8fHw2wqLj/TLGXimJvkv7e8BVw3ou8sdygvaMXjyFmCrCiXx00In2kI+jCl1u3
         Mb30AI0goew47CKP7qubZENc2lvkxoOTGxbwhJUUl+QQgxxGrBRP0gdazk0wKQqp6xy5
         6pQbJDNs+z7bxvZthEvvpVYjhrwVlH9gLL0bnx/iYhboYBRkHLD9R/rc+fseHdxfLJ5x
         zXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146467; x=1724751267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0N19Vu1+Qd03nSpC5/+nmku5ZBvJyZkB8ae+csSMnuA=;
        b=DvBsBWPjbcx2hVKGk9f4apMmlzVyS7D9RxzXrBKmykBXFOkCm7MYyrGWvBfPTiOY7Q
         HowE34gk/k7SNwiTr0VVcY1YjlFS/9gQHY5h0Zz5c84B4vRWZNo8RawPO6XOC9BvBIt7
         FkZ9ZFMVpYyM/GKv2fgblcJS9xb+ltRFKTCXLiiiqdw9HR5fpvIuJwS5yTiYPafFtkfA
         g9wf7gmMZFjjw5+8oC/TH/dspKZ5fXileaG5rOg0VMRLNgl35uyEcA7OdJBIZdTDdWWm
         hCXcK9wlsAXF8aPmByEvUMQunb5HITFQiowk/66WiRYAh7SekH6UTSQXO0gV3R2sOqup
         VhjA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVFlypQsFDVjiM7G8hymp/cLapJU8u8TD7P/AGPyFPNBVuGuAcrCOEu3P2thJgObk1U9hrdQ99w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRBwfFVardBzp9VGNUTbBJFpJrWT8yyvdcqbrF54A61Jh5Grk
	x1c0m7YF0WWc7nJx8I0ju4CjiQy/AvDwWztMlum0FdTHKamnLV9Nn+s7MJmyzJyBvZGeE9DhGRa
	ip2NYLzPBbTCLzlDsvqQ6GNOSWVbQ5PGRyaRkTg==
X-Google-Smtp-Source: AGHT+IFjkt0VAKv0tpQU/RF07jlY1mBSqGYeRlMruxOt0P2f5LLhnlGIQSHhPt3E9SOdHKUF3BdsHPJuJhhp0zY+MSc=
X-Received: by 2002:a05:6902:1687:b0:e13:c7a1:4a72 with SMTP id
 3f1490d57ef6-e13c7a15d8dmr13363627276.12.1724146467565; Tue, 20 Aug 2024
 02:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1724063350-11993-1-git-send-email-quic_dikshita@quicinc.com>
In-Reply-To: <1724063350-11993-1-git-send-email-quic_dikshita@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 11:33:51 +0200
Message-ID: <CAPDyKFqsHL3uatmLZaRzZ_GfkZw-+fURQNSEgvmrf-ini+WHng@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] add device managed version of dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 12:29, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
> These patches add the devres-enabled version of
> dev_pm_domain_attach|detach_list in pm domain framework and
> use the same APIs in venus driver.
>
> If any client drivers use devm_pm_domain_attach_list() to
> attach the PM domains, devm_pm_domain_detach_list() will be
> invoked implicitly during remove phase.
>
> Changes since v3:
>  - updated null check for num_pds to num_pds <=0.
>
> Changes since v2:
>  - made devm_pm_domain_detach_list as static and no
>    longer export this API.
>  - added null checks for num_pds to avoid adding a
>    devres callback for the same.
>  - added bryan's reviewed-by from v1.
>
> Changes since v1:
>  - fixed the warnings reported by kernel test robot.
>  - added stub functions for !CONFIG_PM case.
>  - removed un-necessasry type casting.
>  - fixed the issue with remove sequence.
>
> Dikshita Agarwal (2):
>   PM: domains: add device managed version of
>     dev_pm_domain_attach|detach_list()
>   media: venus: use device managed APIs for power domains
>
>  drivers/base/power/common.c                    | 45 ++++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/pm_helpers.c |  5 +--
>  include/linux/pm_domain.h                      | 11 +++++++
>  3 files changed, 57 insertions(+), 4 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

