Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37C82DFC98
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 15:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgLUOLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 09:11:54 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36688 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgLUOLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 09:11:54 -0500
Received: by mail-wr1-f48.google.com with SMTP id t16so11216170wra.3;
        Mon, 21 Dec 2020 06:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dRfOKrfA9+95u+JXeBdqaPk9bb6AjAjfiGZH9/kyq2c=;
        b=M0QOpyz/8oKG+z7q63bM+70j1zVSh03FIt3UYxATetsdhc/ijqoJ1llBLjQPrRyHYu
         0J8nGlLvzrCVjHMe/7r+jHoqz7wL1jsP7duS97Iwqy5B5lPPMRG0E1jI2XGhkcT4AZB+
         wZPEW94Ib1XfK7O2l7vj+1RmJJUVjvtSb3bGhrFlsohZ9YiDA0VtubyqIA1FgDkPBSDt
         6mG77HrK2Yd1R7wraBAkD6QVqKxxQMUAiYBHzMtswzXnBIBt48sOT0fzqUEB390Hbo7g
         UuKgn48275vlSJDsq3HHx9q6n6L4LRz23PjKfMLObe5pHWSl/GiXsbpAvJ9FsOQLTVs2
         W+JA==
X-Gm-Message-State: AOAM533yB8cxrXxTQ81vn08BZfPk/GOHK8eOnR4zr4ow8hENdblN3wuX
        IHeidVPZEWcaNsFd0yx8bhc=
X-Google-Smtp-Source: ABdhPJyFLbp2yFuolPYyYG9a3FRmCo6x2YzonajYXCyggm4h4pdL5U1JaFWZ8VXC5yerC0BwjDtKoQ==
X-Received: by 2002:adf:ee90:: with SMTP id b16mr18953642wro.221.1608559871621;
        Mon, 21 Dec 2020 06:11:11 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j59sm28021679wrj.13.2020.12.21.06.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:11:10 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:11:09 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/6] extcon: max8997: Add CHGINS and CHGRM interrupt
 handling
Message-ID: <20201221141109.GA33797@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221095001.595366-1-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 09:53:08AM +0000, Timon Baetz wrote:
> This allows the MAX8997 charger to set the current limit depending on
> the detected extcon charger type.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>

Don't do this:
	In-Reply-To: <20201202203516.43053-1-timon.baetz@protonmail.com>

It's a v2, so new thread. If you want to reference previous work, paste
a link from lore.kernel.org.

Best regards,
Krzysztof
