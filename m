Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844FD2296D5
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgGVLBw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGVLBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2020 07:01:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C9C0619DF
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2020 04:01:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so1451557wrs.11
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2020 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sISKqG3zytnruvPe3/sMoutNe9YJtA5YhpTs8Hs22Q=;
        b=GfK17w9A7urar0bbCno8XvDiWdKYtCn/FkvPPArA+GEu1ZXhnvZ9bAoakVcJhb1LwB
         lJAYp1XvgXaOSu3TD6gMvEwpokTWVzY+8o/e4yDWUWImmsTeZ5eBCvp3ffROdkEXsCOC
         O7wNzG5tJKLjVlkL0IhrVBD26gbfXwfvzDXO9UkMBoeOwJPervPItYGXbfzI4yQHGSc8
         c9kaNVZ2W8Q4AErxprcIx01PSnUQXWkcUQk7+f6VfHZMNAn1tSSoVqT0JzlHEKRALQ6x
         MuNIEfo7OLSYXpX/IJQKjmn+I1MtwyxTRCGxaSjFHCWwyoHfJbOFfTCZU6fvmms10wG/
         lhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sISKqG3zytnruvPe3/sMoutNe9YJtA5YhpTs8Hs22Q=;
        b=MvOif/IE9RqBqJZbTGRWZyRkjlGHoWp3IJIk3RvKaIVErtYd3fRoPVDwzV1d5m7SNs
         agAMv6ZKjH+rnIoXufAAhqQVYjd3cSANVq8yt7IgixCLzJBeuG4NaFkFrvfFx0yBxiJ3
         N6lTvjiN2gyR4L/tINYmT2X60A3SXmcWecD7bq4Az/8JLKwLxwuOTGzsrsDmkPHf0huh
         X6d+Uhb/0aFQmU4PJypXD+LyK8J0hjZej996TeRdxtP3BMW7dLr1SmDP9kpZ8ezZ1ko0
         3dnnAKusEK8W0Qekpt/aKhVwRCWBWQ0kA6EmoP+ByrBKbKRqpj4Bic9uQfP5BU/UGieF
         tM3Q==
X-Gm-Message-State: AOAM532eEcz4QBezd/a8nXVSXozLU0iFHMOaMZ+uYBBl8PtY6MdGKCbP
        a1u/qxu/+8QGaGgLTDW2z4xSWRghPqw=
X-Google-Smtp-Source: ABdhPJzvbJiEbZhTK9KtS+CuXvFxkQ841o0YWwDshK+1uhQj4fRq4YoTcgct5xjCsALL1vxZi3oyjw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr14176435wrn.110.1595415699849;
        Wed, 22 Jul 2020 04:01:39 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y6sm41256164wrr.74.2020.07.22.04.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 04:01:39 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add interconnect sync state support
Date:   Wed, 22 Jul 2020 14:01:37 +0300
Message-Id: <20200722110139.24778-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bootloaders often leave some system resources enabled such as clocks,
regulators, interconnects etc. We want to keep these resources enabled
until all their consumers are probed. These resources are often shared,
so we must wait for all the consumers to come up, before deciding
whether to turn them off or change the configuration. This patchset is
trying to solve the above problem just for the on-chip interconnects.

The problem is solved by allowing the interconnect providers to specify
an initial bandwidth values, which are enforced during boot as floor
values, while the requests from all consumers are being collected.
Then the sync_state() callback is used to signal when all consumers have
been probed, meaning that the floor bandwidth is not needed anymore and
the framework is ready to re-aggregate and process all requests.

v2:
* Support initial values for both average and peak bandwidth (Mike)
* Skip aggregating/setting for nodes that don't specify initial bw (Mike)
* Drop patch 2/4: Add get_bw() callback (Mike)
* Squash patches 3 and 4.

v1: https://lore.kernel.org/lkml/20200709110705.30359-1-georgi.djakov@linaro.org/

Georgi Djakov (2):
  interconnect: Add sync state support
  interconnect: qcom: Use icc_sync_state in sdm845 and osm-3l drivers

 drivers/interconnect/core.c           | 61 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/osm-l3.c    |  3 ++
 drivers/interconnect/qcom/sdm845.c    |  3 ++
 include/linux/interconnect-provider.h |  5 +++
 4 files changed, 72 insertions(+)

