Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82F3F42AC
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 09:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfKHI7P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 03:59:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33824 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfKHI7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 03:59:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id b72so4428405edf.1
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2019 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:openpgp:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=e1hgerGf785CLDmFjdBmSkwZ7CYxAA5GHC3QoDaUv84=;
        b=yGtIZ68cDcCfzbYOtkcHgJAya3CqiJFju+o1ghD8pby+dS1efblKTsKu92GXH0Zu5R
         OfKynjHDE73q9d10OA+l+CaPITcqZQXymqfGcl7pVM6CR1OfwJCC6eYQjTesDIuK69xP
         mD8zMocye5Ootfmit1RSGVa6Ilp6r4sE0Dcy/N9pM7W4IFcxdv2BK2yf1YeTeHu1nIMV
         iW27Si4KsXfga1v1oj4+eF+7QUx6lgswW9F+Boo9VU5KRHJIE9mg5H49t4tWMKp7OfVq
         SiuSOO6yoh91Fr2LGc+iTSKhPsy5Jdu7W4gFzvR6I2KJhxJolUoLYh9YQPueGnoPQpZH
         ltqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :mime-version:content-language:content-transfer-encoding;
        bh=e1hgerGf785CLDmFjdBmSkwZ7CYxAA5GHC3QoDaUv84=;
        b=Jgwv2FFXhROFdNlrNbHYfooka3qLx2FbClLmA+89hagJy/ecUYOrCrpG7+aRlaN9dT
         RS5Ae1dUlVlBnqwcsOzl5e3mzM7BBE2HribhnPQovxXyv05HnhsOmjkNTl/ciajIsIAo
         QEsut1Kfit5+JhF76Sfm4yx3z/2SbVSIPJDCdexwHcbFYlo0PIi6OCNYQJ0YXblwsNx0
         VJVnCeck5qzBjMNnw1p/SPrle13non+BNndS0ZyvExXCuWt1EKvoe4A8r9f9ARrhsaqj
         xZDjt6lWXDasxULnwmSnZ/h2mdUzI4uRvRoRKHYd9GQexaaXgY6sPEm/hKMhylHcZAim
         O/AA==
X-Gm-Message-State: APjAAAWMRFHIsuACkTYsXMY/veGOeXQOq+p1VynMLLl3nPq3u+Bx8+Fx
        8RIHi3OYkI4z8SOR4/xm8AebbQ==
X-Google-Smtp-Source: APXvYqzE6Zz+fYojrXFq8RAXFWKAJbJFcH/HLgEMz3Ox2gSDMcChzTjhr+Dm0LuQ+RCv9/HqjyTQGw==
X-Received: by 2002:a17:906:d72:: with SMTP id s18mr7603343ejh.29.1573203553940;
        Fri, 08 Nov 2019 00:59:13 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v3sm120036edq.62.2019.11.08.00.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 00:59:13 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL v2] interconnect changes for 5.5
Openpgp: preference=signencrypt
Message-ID: <dd4ff7e3-920d-979b-c29b-7535d84d360f@linaro.org>
Date:   Fri, 8 Nov 2019 10:59:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

This is the updated pull request with interconnect patches for the 5.5 merge
window. The details are in the signed tag. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.5-rc1

for you to fetch changes up to 83561a721dc23330d36e0ce499e716cd65f436fe:

  interconnect: Move interconnect drivers to core_initcall (2019-11-07 19:26:19
+0200)

----------------------------------------------------------------
interconnect patches for 5.5

Here are the interconnect updates for the 5.5-rc1 merge window.

- New interconnect driver for msm8974 platforms.
- Change the initcall level of a driver, so it is available earlier to
other dependent drivers.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Brian Masney (2):
      dt-bindings: interconnect: qcom: add msm8974 bindings
      interconnect: qcom: add msm8974 driver

Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Jordan Crouse (1):
      interconnect: Move interconnect drivers to core_initcall

Leonard Crestez (1):
      interconnect: qcom: Fix icc_onecell_data allocation

 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml |  62 +
 drivers/interconnect/core.c                                      |   4 +
 drivers/interconnect/qcom/Kconfig                                |   9 +
 drivers/interconnect/qcom/Makefile                               |   2 +
 drivers/interconnect/qcom/msm8974.c                              | 796 ++++++++
 drivers/interconnect/qcom/qcs404.c                               |  17 +-
 drivers/interconnect/qcom/sdm845.c                               |  16 +-
 include/dt-bindings/interconnect/qcom,msm8974.h                  | 146 ++
 8 files changed, 1048 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h
