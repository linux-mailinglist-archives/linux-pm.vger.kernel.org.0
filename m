Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEB3913E0
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 03:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRBJG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 21:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfHRBJG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 21:09:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AD602173B;
        Sun, 18 Aug 2019 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566090545;
        bh=Gny4MLZZ9bZM2VYBs8tyCdlHjZFdA6Zs+YnYy3dWizE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=exy5BUiieoRCm4uBC4S1otUruByz5I7M1BWU9W33cGX8QKhxY/RUwMT6YKZwt2dwk
         9IHi/wtGtj1yZtYG5N4R4tmP1cJvvVazdxqiMyDJKliEKhydR/jwF52Qtwvo9Qd/5J
         iygb4J10zAHLyRrGe4cpsmmEYFOsRVNplVp+ROfc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815074848.195806-1-maowenan@huawei.com>
References: <20190815074848.195806-1-maowenan@huawei.com>
Subject: Re: [PATCH linux-next] qcom: qcs404: remove COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mao Wenan <maowenan@huawei.com>
To:     Mao Wenan <maowenan@huawei.com>, agross@kernel.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:09:04 -0700
Message-Id: <20190818010905.7AD602173B@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Mao Wenan (2019-08-15 00:48:48)
> There is one compilation error when CONFIG_INTERCONNECT_QCOM_QCS404=3Dy a=
nd
> CONFIG_INTERCONNECT_QCOM_SMD_RPM=3Dy, as well as CONFIG_COMPILE_TEST=3Dy,
> but CONFIG_QCOM_SMD_RPM is not set, logs as below:
>=20
> drivers/interconnect/qcom/smd-rpm.o: In function `qcom_icc_rpm_smd_send':
> smd-rpm.c:(.text+0xe4): undefined reference to `qcom_rpm_smd_write'
> Makefile:1071: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>=20
> This is because
> INTERCONNECT_QCOM_QCS404 depends on QCOM_SMD_RPM || COMPILE_TEST.
> Here CONFIG_COMPILE_TEST=3Dy, so CONFIG_INTERCONNECT_QCOM_SMD_RPM
> is selected. If CONFIG_QCOM_SMD_RPM is not set, then
> qcom_rpm_smd_write() is not defined, and compilation error happen.
> Fix this by removing COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404.

Can you fix the actual problem with compile testing this driver vs. just
removing the possibility to compile test. Otherwise it gives up on
the spirit of the idea of COMPILE_TEST.

