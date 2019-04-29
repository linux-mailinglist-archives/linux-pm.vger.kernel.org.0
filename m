Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6753EE0AC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfD2KmE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 06:42:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33885 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfD2KmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 06:42:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id j6so11326293qtq.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mti7KwMi+FS7lNJiLBXoxgVN3ENDHL6rbQJBPEZLm8c=;
        b=e6Z9KN+6jcezK4vxJLAWJ4wS+bpxKehspqny2MSjUgaOejBm5SChPK+bwk3HlBKrwj
         cxjDmvPu1FDIMhcQNGe0i3iacMH6nOIdGlv9koKvO+L23/izsmwYOK3RSUyqLnk+Z4S/
         40b9hQCT4A7O4M06WpDPjq4S0Nb9QQNLU2Rio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mti7KwMi+FS7lNJiLBXoxgVN3ENDHL6rbQJBPEZLm8c=;
        b=sTHWDJasXCiYBt0AOORff7ZpUqxFeOaRRHerkK3nIjrPlshNWm5pS5CDFBBqtBakRI
         lYT46aW+3RexjwCIQtRAfqRLQtaZNJNq669cdXhtvSpMSzZSq13Z7vZGbm1BSfIaSe11
         DAGHN7VOMcsqj82E9FHs6iiH8Gy/y9sBqhTA7Dj8Pi/5Q4TnN4iEhUTEMmJBN5DLkS/h
         h7v/zSldmH5fu3fi4ac8mo8xBkJgeopk8hQ2Uqx5Odt20IAkiSlgD1iLgIuk6q4mt2Ym
         yTeIiYjV6d37kWVIYYS+I6iwqFhW2lvjWdEurOy9Px8OfIkFYQW/5k6cf4b2g1O6GBtP
         4lVw==
X-Gm-Message-State: APjAAAU0Ysvnz/tMQlgT98CnT4I4Vb3sc5vXfxYej7L1yPtDn3t53OVD
        ssMa+7yFM1cWVVl/FdcMpFxnocuZcZmskwOP
X-Google-Smtp-Source: APXvYqycyiTnyRhxRweWHTdwDmD9ESRo9QrNZLKpgPCn67kakGwpUwoKDxnpO5ljOld6iEAj//c+1w==
X-Received: by 2002:aed:3ebc:: with SMTP id n57mr35956736qtf.118.1556534522922;
        Mon, 29 Apr 2019 03:42:02 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id p1sm6725543qkb.43.2019.04.29.03.42.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 03:42:02 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id f125so5596788qke.6
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 03:42:01 -0700 (PDT)
X-Received: by 2002:a37:4c7:: with SMTP id 190mr37260660qke.128.1556534521618;
 Mon, 29 Apr 2019 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan> <20190403195718.GA74723@google.com>
 <87o94tutdz.fsf@kamboji.qca.qualcomm.com> <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
In-Reply-To: <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 29 Apr 2019 18:41:50 +0800
X-Gmail-Original-Message-ID: <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
Message-ID: <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sriram R <srirrama@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested-by: Claire Chang <tientzu@chromium.org>

> Still, I'm quite sure that the WARN_ON()s trigger during system resume
> regardless of the hw/fw combination.

Also see this on sido:

[    4.925278] ath10k_sdio mmc1:0001:1: qca6174 hw3.2 sdio target
0x05030000 chip_id 0x00000000 sub 0000:0000
[    4.935721] ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1
tracing 1 dfs 0 testmode 1
[    4.948750] ath10k_sdio mmc1:0001:1: firmware ver
WLAN.RMH.4.4.1-00007-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32
b98adaf8
[    5.132728] ath10k_sdio mmc1:0001:1: board_file api 2 bmi_id 0:4
crc32 6364cfcc
