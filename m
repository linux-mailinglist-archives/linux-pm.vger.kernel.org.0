Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE13070A27
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGVTxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 15:53:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55742 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGVTxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 15:53:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so36329795wmj.5;
        Mon, 22 Jul 2019 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cpB3PKFs/+RNz6CzNu73YznyTKNKRjiULkUbbvNL4A=;
        b=FMeIQosVJpsSyQizbAdM5w5gCoNZ9YjgkrhzQyFpPEZ6yGbnaVaGTKix5MpzA1+nFw
         TPLF9F94ldsU+stwhCSShs0/EKCsuqeMcgvWDXIaN4um2tcwd3hEoAogW6Dh/fMr0uz0
         ErIl9pc9vwThWFvq9+PsG0EKASzESlzNUxGe0SfrGPvnu0Wh2Zh5GbTwhFQglLasZUx0
         IRSHPoybDQe40mn5Z/vt46KEz4GkAwZ+pFjFqXfTlgBgKmYxxXoLxET4ecnTGPQ9+lTp
         QREBlHnF0q4kGWdHeKPc+oRLOwyy6RVY1+JMKxymOdPhsaWD5UjvVNTi3tmUXfgjwH50
         yp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cpB3PKFs/+RNz6CzNu73YznyTKNKRjiULkUbbvNL4A=;
        b=QGtRUwHemj6RxDXSybitXIFeXKZTfF+sVMNuxZ+Wmo2TrW7o+7MVqDDMlnAgB74Wvk
         qMnAH+Js9ZVdJeHqbFSqsWAi4fH/KXBa1ypvC5Bbnm7GHT0wlAaOCfA4wlGDqNbwx561
         5/zZS+fFtOojdfk5Rs24z4QvjP1iyMfOfQbLQCrlTp7WMLvCE9t3GYP2jZXhJaObD9tD
         NL977gow/ji3YaFJgayKRi1CzD4FqIcyzrGhnctAUnNUbEuM5B2JvmKCodXS/pm/13Ek
         /kL/TXQcQcHdlvHwiKhG/n21FsVHnBQ574Rohr82GRba1srOQdZu0LIaB8t7tT0XkxEn
         9a9w==
X-Gm-Message-State: APjAAAUS5X/VnmWDT5IF//OnJd2hJP9QsqQzK2uPBiR0fZbcvTqRZI99
        5yTLBKoJ6Ne10AKpnq7yrNw=
X-Google-Smtp-Source: APXvYqwLmtg3xVtKc23mGLVZUIKYCwmvX8GSvq1g5RqXzcH4QIoCHY9XDNowPeTdHmt+tEdUgSidRw==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr66479064wmg.27.1563825196792;
        Mon, 22 Jul 2019 12:53:16 -0700 (PDT)
Received: from localhost.localdomain (nat-113.starnet.cz. [178.255.168.113])
        by smtp.googlemail.com with ESMTPSA id c65sm37382975wma.44.2019.07.22.12.53.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:53:16 -0700 (PDT)
From:   Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Evgeny Kolesnikov <evgenyz@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Add support for WD MyCloud EX2 Ultra (+ versatile UART-based restart/poweroff drivers)
Date:   Mon, 22 Jul 2019 21:53:00 +0200
Message-Id: <cover.1563822216.git.evgenyz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset consists of the DTS, which describes the WD MyCloud EX2 Ultra device,
'poweroff' and 'resert' drivers for power-managing MCUs connected to a board via UART
(these drivers are more versatile than qnap-poweroff and could be used as a substitude),
and DT bindings for these drivers.

The difference between uart-poweroff and qnap-poweroff is small, but important:
uart-poweroff is able to send to an MCU a command of arbitrary length, and the command
itself is defined in a DTS file for a specific device/board, thus making this driver
applicable to wider range of devices.

Evgeny Kolesnikov (5):
  power: reset: Add UART-based MCU poweroff DT bindings
  power: reset: Add UART-based MCU restart DT bindings
  power/reset: Add a power off driver for UART-based PM MCUs
  power/reset: Add a restart driver for UART-based PM MCUs
  ARM: dts: armada385-wd-mcex2u: Add DTS file for WD My Cloud EX2 Ultra

 .../bindings/power/reset/uart-poweroff.txt    |  38 +++
 .../bindings/power/reset/uart-restart.txt     |  39 +++
 arch/arm/boot/dts/armada-385-wd-mcex2u.dts    | 313 ++++++++++++++++++
 drivers/power/reset/Kconfig                   |  14 +
 drivers/power/reset/Makefile                  |   2 +
 drivers/power/reset/uart-poweroff.c           | 155 +++++++++
 drivers/power/reset/uart-restart.c            | 204 ++++++++++++
 7 files changed, 765 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/uart-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/uart-restart.txt
 create mode 100644 arch/arm/boot/dts/armada-385-wd-mcex2u.dts
 create mode 100644 drivers/power/reset/uart-poweroff.c
 create mode 100644 drivers/power/reset/uart-restart.c

-- 
2.21.0

