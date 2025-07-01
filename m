Return-Path: <linux-pm+bounces-29886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E0AEF44D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC46D1C0003C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB981271A6D;
	Tue,  1 Jul 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9GRNXLo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D427144F;
	Tue,  1 Jul 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364019; cv=none; b=GPBqEHe0fohqZZ/7xdPKhPfOLzr9czdWDb24tHPz/ZcQJFMxGQqvqN8CzlFax2k/CXIEX1vvnLGrPh0VNKWJ9vOQFo2wSMOLJUhmyBA/7MzENNUQ/JmMBzTG15gzQVjcA6KFmHeYp2y+KoH9M+JipAfvnV7PolIjtJz5GJnXuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364019; c=relaxed/simple;
	bh=et2IZnRBRRE/i9WxwyjEgwqKCwo78jqUL+Pk8u1GQPI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ip8CZCaPlqXKqwYgLOy4vBrZOCmm+KxoV6aWLTN2YfSWTmC+5agsgh6csiw9rDX1AohF+5X/XwyH0TJUJN1SumSOvpgTvV/YzjL6bSAOyXsG/9/4F1TuyIhYMFYFC7T0ACj1rrBkKIPiWDkxlpXGe6oJWXsp+OC5K5DeEIe+/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9GRNXLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A08C4CEEE;
	Tue,  1 Jul 2025 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751364018;
	bh=et2IZnRBRRE/i9WxwyjEgwqKCwo78jqUL+Pk8u1GQPI=;
	h=From:Date:Subject:To:From;
	b=n9GRNXLoYivvmGDVRoIDIyedog+EzJ5FGSUTFXFhwHW1f5sqmGQE6eEphaq1KKAc+
	 ghCnlwbyVof7yJSd08v3I1nxCoMkt8pzN9eEaieNrV1H+lMc6wq6j9boLp+DA2SR9m
	 oYkjyXpZvLlC74qJQGBc+jZTt0eFvQLLEmw+x0EiQIcCaWKokxxlr4VCRLHy3glkOS
	 UuKw65bFEtRpoAf1XK8nJOge+CQ5I3psOkHMHzV1JN/qeb9bmMYp654lbN0QyCwRrP
	 gtUQkV9CCr43iXo+O5ZN7ZFD6mEkVs1YE+1h0AN1aWCYBXQJb5FbVFCrvZoLwrewDY
	 PF+ARXHP3yeHA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6119b103132so3351119eaf.1;
        Tue, 01 Jul 2025 03:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBFBrZba9xM2IlBa6RxAN/8tTA95LW+NHDockgJ6k/fs93e+D9cVSKqgAdF3g71yZdqYPZv/s5ubMCKqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQT4JD99C+gosT3DQS+Zm8+OsVMU3TpwaUX4/EUiKRIdzkc/B3
	mNuVfKhqjDzINA1fYX/uk+EO6uvAgb/boe1eRW2NWLNMJJ5OU5cgPWtEuM5XsZUDm7zmnlUrXUH
	lT0IBbKMiYztUo2oTAm0L6lSoDICAow8=
X-Google-Smtp-Source: AGHT+IFTl2k0lXDZlJkUoOcLMi5F/x6MEuDezlqY6j7C6OALm3MQUJeKT28Nf6e8kb2grbHpRP/YFa78F771K+w7DHM=
X-Received: by 2002:a05:6820:211:b0:611:adce:2cb4 with SMTP id
 006d021491bc7-611f38e0c59mr2028775eaf.3.1751364017406; Tue, 01 Jul 2025
 03:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Jul 2025 12:00:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com>
X-Gm-Features: Ac12FXzp5NJubuGZeSHIXJwgPKHM6t8zPh4qH_y-grJkQXUgum4uie1P0AGxREg
Message-ID: <CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com>
Subject: [GIT TAG] Runtime PM updates related to autosuspend for 6.17
To: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Everyone,

To receive runtime PM updates related to autosuspend for 6.17, please
pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-runtime-6.17-rc1

with top-most commit cd4da713f99651e99fbce8ed6b6ec8f686c029a8

 Documentation: PM: *_autosuspend() functions update last busy time

on top of commit e04c78d86a9699d136910cfc0bdcf01087e3267e

 Linux 6.16-rc2

These make several autosuspend functions mark last busy stamp and update
the documentation accordingly (Sakari Ailus).

Thanks!


---------------

Sakari Ailus (6):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time

---------------

 Documentation/power/runtime_pm.rst |  50 +++++-----
 include/linux/pm_runtime.h         | 187 ++++++++++++++++++++++++++++++++-----
 2 files changed, 186 insertions(+), 51 deletions(-)

