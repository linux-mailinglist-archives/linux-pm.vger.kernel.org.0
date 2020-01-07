Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD513373A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 00:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgAGXU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 18:20:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAGXU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 18:20:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so1462252wro.2;
        Tue, 07 Jan 2020 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8Xx2TMo98HOlnNXLfC+Sqmt0X1ycOlUNLncTAwPcpw=;
        b=ef4VoKVqe4g5ezm4iwoyskM7fNVE5Pe8ZwAriX4UoHXrg2UenS01yC3mdQNhCDlOFi
         zMx+THsG9CmCaNAh0KTvTGRQuxcIVdbfM/jMDy3hDLru3fXQF7n0SUZzSTbuy1p4ukPD
         zD6XYUTu9BErJHwbe8waeqaTPy5qvqEOl95iEfhnWn1Y68mM7OTNr+Zmj/Xf7Gp0ubnc
         Bo76HZDwI8IBpQjT9XVBxgEnfXQGS3M1qjgY5ifNX1KNEVOCECG47GvDbDaZItHdlLNH
         /6CmVCU868YRshLAfM8IZZzpljxZnrGt5u6aaVyxyxRACP2q/P5BtyhDzdYx4iKEJnYv
         vgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8Xx2TMo98HOlnNXLfC+Sqmt0X1ycOlUNLncTAwPcpw=;
        b=ciiim2+P+3iTAdFm1pZmzts7xf33ofvTKf7NzbBxlJfbViIqm25JNE13v6ysFc8vaM
         O0G/EpUOyJhoD7Lsa/Jqnk9aJYJ7WNKL8MErbgHEki9NcOfJJ7clEIi0Wvha87f2xoXc
         aL8KxlLfm8lq5fN1oZ1gzf/r6U/e0WwylXZXsZADhABbgG/vXy0porNpLRUtCOeV0kHl
         unNB37vpPdSzrKbdBqfCY43VK7J3HY7MXfQeeR/GwcmZ2MIWPGxR95r8Zs0OyN0SDJYy
         g9ZAlG/K316mPLbKYSF4gqTaSrpDl+WjITMdPhPfmEYXdkjNNQytJ9/Rjx7XFIdmJKWb
         V91A==
X-Gm-Message-State: APjAAAWCtYRje5l4SD0uzVgra6i793nRaY36kqnywFaUkrjVQlzKd465
        NCkD8X7ewR7elBmcrUszThg=
X-Google-Smtp-Source: APXvYqy6aZ57xs+O3szbAeVwXJr7Jzj0ibfQay91BV98G3in0RgnjJOoPl8vF91zzF2H+4FTVXGR8A==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr1313257wrn.251.1578439256295;
        Tue, 07 Jan 2020 15:20:56 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n3sm1669577wrs.8.2020.01.07.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:20:55 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        jeff.dagenais@gmail.com, edubezval@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] make generic-adc-thermal less noisy
Date:   Wed,  8 Jan 2020 00:20:42 +0100
Message-Id: <20200107232044.889075-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I want to use generic-adc-thermal on the 32-bit Amlogic SoCs in the
future. These have a thermal sensors which can be read through the
SAR ADC (for which we have an IIO driver) on those SoCs.

While testing I found the generic-adc-thermal driver to be a bit
noisy when operating in well supported environment:
- the SoC temperature sensor on the 32-bit Amlogic SoCs is typically
  loaded late because of it's dependencies (it needs data from the
  eFuse and a syscon to calibrate). Yet I still got a message stating
  there's no lookup table for the generic-adc-thermal defined (which
  is expected and perfectly valid on these Amlogic SoCs, as the IIO
  channel returns the temperature).
- the IIO channel is correctly defined with type IIO_TEMP, yet the
  generic-adc-thermal driver still prints a message which first lead
  me to believe that I passed an incorrect IIO channel (one that
  returns a voltage).


Martin Blumenstingl (2):
  thermal: generic-adc: silence "no lookup table" on deferred probe
  thermal: generic-adc: silence info message for IIO_TEMP channels

 drivers/thermal/thermal-generic-adc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.24.1

