Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66F0F4C2C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKHMyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 07:54:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43774 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfKHMyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 07:54:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so6907381wra.10
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2019 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yshGOj9Ch5cE328Kakq2jbK6ElAXVlG2qF7B16agtk8=;
        b=jXk0laZiZ7dVouzVSZZEpr3BtIY7fCiWtvJqfuBiz2sZLnWYB0f5Prc/G/YVedO5Kx
         Ni/U9FrBR2C1RkiAkPrTPlcEQhN4aLoEOIjkJudga1tIJ92CV+bf6vVjU3g8sl9TN+Ef
         AUPC34Zjwl+ypl2U7UnsRkwH9IBJBwSvN0Cm0XkSN1YrsRenzHZS67e9CTFg0YGXAKFH
         vGawzaFOULVSKEfQS5SsDZIPwh/akCgnnoeE7MydolQKKFORjZt8AxvcyxbmFFugD/Mh
         GlOu3jFqY9N37EmvBQes/I83BaarnYSp7vzhXn4SM82kU05CnpVRnbMGnyVv4cmtp918
         Zg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yshGOj9Ch5cE328Kakq2jbK6ElAXVlG2qF7B16agtk8=;
        b=Ys9YIpRS+tRECSeEP2rjniMm/tFiV4Y0AJ0wEslVDKrpD3tpptjt+akGRX9pL6COKY
         D1ASXfCOCgpdCTIUoemjDCvBXJld6uNOVqBlb/FyDuj9n9F7I09cln8h9dQWUBi0Kkr0
         feskvSsUEn8sPWfbjIq3LZApROBqj24Zzv/Y8k3WBL6fkQSADr2jmtTFCHXBJP/x66vO
         05HADOAer7lAlpW0zmpCFx5lyL9LhK5nNWqJITcqMKx+bH4VuOOl+Xg6TGpytSao27ul
         CPACQSvh/YLcC5xOLEJ2FZtC1geBuz1sH8ZegSPEzastbpZaT3qhCj1g/QHUlkIyBzP3
         uA6g==
X-Gm-Message-State: APjAAAVwDblg82Bpr2hoQ9y680psyh/2Pgn9bfIVL9YEBu/QeoUKEpV+
        EFo/XUI4DglyG7Nb6GBOVwQ4yQHSwTQ=
X-Google-Smtp-Source: APXvYqzbNikqrJSo8k+BuM6iHT4Ihgi0eBvausj8E13CkiAJyXZO00bBITlai5QO/dMzM+Y7XTgdpg==
X-Received: by 2002:adf:d842:: with SMTP id k2mr1401685wrl.163.1573217659672;
        Fri, 08 Nov 2019 04:54:19 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 19sm8515234wrc.47.2019.11.08.04.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 04:54:18 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 0/2] interconnect changes for 5.5
Date:   Fri,  8 Nov 2019 14:53:47 +0200
Message-Id: <20191108125349.24191-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

This is new interconnect material for 5.5 which is a new driver. I have
dropped the fixes that you pulled already.

Thanks,
Georgi

Brian Masney (2):
  dt-bindings: interconnect: qcom: add msm8974 bindings
  interconnect: qcom: add msm8974 driver

 .../bindings/interconnect/qcom,msm8974.yaml   |  62 ++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/msm8974.c           | 784 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++
 5 files changed, 1003 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h

