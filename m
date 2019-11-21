Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C756105D35
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 00:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUXlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 18:41:15 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41451 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 18:41:15 -0500
Received: by mail-io1-f67.google.com with SMTP id z26so2145669iot.8
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uACTtkuIJfMaBrmrOMjqpsbLeXCbKKhLGPjsdUGUn50=;
        b=ATla5Mm3z+aOSJ66NK85YT1q/SnFkBStQC85FhCDpIB9Top6rOmlTlPOyJIUuzjr8o
         6K53jRv0jQY8JJhsE0zzzA3Yh+g1U0ynGzpnNk1J27pNFx2cTJQHqhQ6DinQWKVvs//i
         TT3JD5gxhoEf2clL7ZIpum5r2Xn6IsRfa655X3Ck7rrsV7EoAQPCPLOfT9yxDHi7aKIJ
         cYk3nZtXTb/oqDHDTvx3xNCdHMeLaDHiv9QyqUZksP55YyxUgywibz2EbJg3yFvmS00f
         /I8+3l8qmalkpGCA5v+iJU9PPKR8BbRV3aApbaSwxSTHOjmrPeQIE/FDuE87o6HA9Yzj
         xKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uACTtkuIJfMaBrmrOMjqpsbLeXCbKKhLGPjsdUGUn50=;
        b=IidBvxvJPXhTunz6iJBrzPyuHqSVws/zmk8Ok1r+X0AZQ232GHwdm1VKqrY0SpH8xa
         tM8zdVgl6KFBa97S9xhh7RnAF52XFILOfHx5lIFWzPgeHMahcsSX49kX/FBbvzuN4lR0
         c1GQ4mkIvWEp2183wCD0MjsyxP0pDU+6Aa0736/vKKrWXIhtsq0nMCziewRmLlgCeA5y
         kcQUI8gCkj+OEIdIe2Y2cv0CuUjPmVQn9pOo8W4Peyl8dA0bdTvFQUgkHaQb84ZzDlhn
         3HEoADWdGH9sY0LyUO6mdH7FwwF9iWY3jGTUooL0b79DC0Gkf8TKQUlXRYoLWL7YkIXM
         cgUg==
X-Gm-Message-State: APjAAAXCYZ25l/W2/BYwysl3S2ee4cZjFK5A6cKvNKh61JjqhVZ00Pc9
        OAnQeKLe/5o0Coa7KieZww1u/w==
X-Google-Smtp-Source: APXvYqxM0XCrMtbJZmjbWGBiasGzyQbYZ89bcym0RaLoJmTu15rbGtwOEw3ToJQeqvDJifnXmvORMg==
X-Received: by 2002:a6b:e518:: with SMTP id y24mr9835193ioc.244.1574379674403;
        Thu, 21 Nov 2019 15:41:14 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j23sm4544131pfe.95.2019.11.21.15.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:13 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: avs: Fix Kconfig indentation
In-Reply-To: <20191120134004.14167-1-krzk@kernel.org>
References: <20191120134004.14167-1-krzk@kernel.org>
Date:   Thu, 21 Nov 2019 15:41:13 -0800
Message-ID: <7ho8x4n6g6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Rafael, feel free to apply directly.

Kevin
