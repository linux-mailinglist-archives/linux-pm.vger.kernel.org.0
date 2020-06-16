Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E41A1FA970
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 09:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFPHDE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 03:03:04 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41125 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgFPHDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 03:03:01 -0400
Received: by mail-ej1-f65.google.com with SMTP id dp18so2100945ejc.8;
        Tue, 16 Jun 2020 00:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+RINVE0XAWlLx/NciRZL3CxZwQ8/XrClWGZWDn4nfE=;
        b=SUl4rQGIHivhb71P38XTo3bb5chjpqgajocfue2hqT6SnY6ArjPxgQTExOnU4iZ5b6
         QX2QjT8b6UOVGPN0ikVzyb93tmRiuHXZzz7iFdjSk2lJSp92QghQMckn5Bd0No/eaJ95
         SqjC0vjQl/DkBkBv757gP3kgdLTTZux1+/M64fB4lQWS658ZsRs3+xG8wxCA5MDktY/3
         tVDlK3IDx/bd1qtPARuNae+XlpV6SKp/ya4qsQpednwqot+T2QVWF9l/uzgr+VfOtomv
         mCPTHv6kir7GauYdNwQeYztpU/s/gIzfFxULEc8WGhq6ofHH+ob5EXCWWqVY3kpCLoUS
         pquA==
X-Gm-Message-State: AOAM530yjinjsQU8j5BI9o7G+e3IqytlFNG5r/VtiltddsUbPEmNr+yr
        eRShRpsoO62B1me90lHew6s=
X-Google-Smtp-Source: ABdhPJxl4oyx9iQxhRGORq2pzdp+iXjssmPRevhLNp+7V95nN07E3myCv4N1zJvRvpw1FVDX/qymKQ==
X-Received: by 2002:a17:906:4b50:: with SMTP id j16mr1504437ejv.415.1592290978329;
        Tue, 16 Jun 2020 00:02:58 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id ce14sm10568034ejc.3.2020.06.16.00.02.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 00:02:57 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:02:54 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH RESEND v4] soc: samsung: Add simple voltage coupler for
 Exynos5800
Message-ID: <20200616070254.GA20282@kozik-lap>
References: <CGME20200616065834eucas1p268ef16744422664c783b17f0a18c53e2@eucas1p2.samsung.com>
 <20200616065821.29616-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616065821.29616-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 16, 2020 at 08:58:21AM +0200, Marek Szyprowski wrote:
> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
> ensures that the voltage values don't go below the bootloader-selected
> operation point during the boot process until a the clients sets their
> constraints. It is achieved by assuming minimal voltage value equal to
> the current value if no constraints are set. This also ensures proper
> voltage balancing if any of the client driver is missing.
> 
> The balancing code comes from the regulator/core.c with the additional
> logic for handling regulators without client constraints applied added.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Thanks, applied.

Best regards,
Krzysztof

