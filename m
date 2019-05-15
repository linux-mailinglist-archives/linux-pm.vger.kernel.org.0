Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3CE1F742
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfEOPRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 11:17:50 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:32781 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEOPRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 11:17:50 -0400
Received: by mail-pf1-f171.google.com with SMTP id z28so155098pfk.0
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tJrsEwTh6VOB02i4tRZ48loA1l+OFahBfphYUwfCgro=;
        b=tPsgOk71tnB8xagO6PUFhXjz3i9qZNiAXfBCL5MYt0mXGBkMALJe1RzJ4Hd2j8irsy
         mTz+a3Y4ADvFdd3+h7Gnl34SabrZUgv+j0TJkvZW8kq0hN5ISlqTFCJ+l3dVZ/tBOhwg
         RGx4ThGXFosH52Uk4NGvRcty0i6ZITB0N6ZTGHb1vpPj5lNTeCDyqRGTpVQWPzrsHSo/
         XOfUcGxRTxSULZWzCa1y6RQ+5JgWaGs4ZzAGquPzCeXTtYwA5eNVkQJrGMLtCV7fSMdA
         AbVJOHZ87SjTEXMP3VXN++xAcTkGW1JTM1dgolZaEsrpx5jG7NmHk/AVJF2OVcZ6ehuL
         MdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tJrsEwTh6VOB02i4tRZ48loA1l+OFahBfphYUwfCgro=;
        b=dgpjTebx2BcLsZiDoItdyRW3K+Q4CBUUM1zTikCPqhiJzeAConUje5DTdXuxLlTJpE
         zIiRjenwoOzYKRFBfIjuHMilxcOvGZBh5Zfto18TV7LANTXeanwt3vBWvAlfW84kQIoY
         rs3czum1Ggz3qX0IE6QJRscem021ZhvWgHgLTUAEuAqRbr8+tw51RWooc9Jy0wsiVr5O
         tYd4izP6dYcIokV8bQH8bPPSPJwF3u9ILab2pMiP8i1ZIMFnSfDjIAUnj6g1y5vHxKP7
         NdM2caEDYUDdyRp5VI5DAL31k75czadeVGRfyVxAeXs7Mp2WY6zIvI44+JNpA4DHwwtm
         55XA==
X-Gm-Message-State: APjAAAVr3n7KspeGh4yGsiF/y11L26SnzRifMWN3K4MiBJWK+5RXXP9j
        DWudly5KVvdld+PnjId541o=
X-Google-Smtp-Source: APXvYqxRbyYBXB4Zw73wrOyVJ2+L9aw93QKTrYM++mNstEXwa3i3xJ4zz4BRtr7zUTmCFkzui03Jrw==
X-Received: by 2002:a62:38cc:: with SMTP id f195mr48138547pfa.15.1557933469671;
        Wed, 15 May 2019 08:17:49 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:b16d:d4:d5a2:4dca])
        by smtp.gmail.com with ESMTPSA id 85sm5544888pgb.52.2019.05.15.08.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 May 2019 08:17:48 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/2] nvme: add thermal zone devices
Date:   Thu, 16 May 2019 00:17:15 +0900
Message-Id: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NVMe controller reports up to nine temperature values in the SMART /
Health log page (the composite temperature and temperature sensor 1 through
temperature sensor 8).
The temperature threshold feature (Feature Identifier 04h) configures the
asynchronous event request command to complete when the temperature is
crossed its correspoinding temperature threshold.

This provide these temperatures and thresholds via thermal zone devices.

Akinobu Mita (2):
  nvme: add thermal zone infrastructure
  nvme-pci: support thermal zone

 drivers/nvme/host/core.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  24 ++++
 drivers/nvme/host/pci.c  |   5 +
 include/linux/nvme.h     |   4 +
 4 files changed, 397 insertions(+), 4 deletions(-)

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
-- 
2.7.4

