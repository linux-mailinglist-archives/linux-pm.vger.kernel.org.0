Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47D90CAE
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2019 06:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHQEDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 00:03:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41422 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQEDf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Aug 2019 00:03:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so3212481pls.8
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2019 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=pXBlTpO2GjUBQ6jSlgDI9YWY/1MbzSJdSmD+5A3FCkw=;
        b=PtNGh7vdCiqdD4hRdr+Xk39n62axtunyuxtDDhHVeiRibm/5+qNv7A0Qq5H0fQrvFb
         dK1to8T3Hzk4lk1FgmxzaeHrs0J8Vrw3AA0+NUUBJhxrZ7keL3WoPRDblDOzVtLBvHRN
         NLaK0cMstfNtFwF9dRVjl5PnxkN9j3QyjgI3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=pXBlTpO2GjUBQ6jSlgDI9YWY/1MbzSJdSmD+5A3FCkw=;
        b=DgG6jIn0x6WLkCIoP6wv8+SDr8BNL6eUp5re1yZBGaqxXZwegfjteargyDGLbC2o0g
         oX1DawGYkcThrH33CFzrGM3N9Lt63UGSyz7DNj3OS9O0F9ARGhrtfeha3cRYPEiTI5oa
         oxjZ/Koi6J6cpafJEKtFEb2eJtRFcFwfrktrhlBRZDon/FIefeWWVapRFivp/kEMun/0
         r9pQaI34YuR6dTtQ6jiEHIPHqqCgi9GiZb6I+8QU5CsOyJEeMu1OtgZCVc7EQuliILHy
         dY0LemQHwkfJb3/DPP6/aho3D529bIG5LYlFTfUE0FNRNDXqEq52NC2WJXBiDaBz32Jf
         QsYQ==
X-Gm-Message-State: APjAAAWxplhyiHQGHvAi2mmR2s+u8fz1Zhv2uD8jTlT5nXpe7r8o7V7+
        fzXty6TvZI67fDSVTTCS0s8qVWJDSKYeyQ==
X-Google-Smtp-Source: APXvYqwK84XyJsvkHeRp3YZ8xSrSKr9P+aAKUhjZ/tpZXI4A6mRuv4TX1+/8f9hDVYtb92wTY6DJLw==
X-Received: by 2002:a17:902:2888:: with SMTP id f8mr12244041plb.26.1566014614940;
        Fri, 16 Aug 2019 21:03:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z16sm7101782pgi.8.2019.08.16.21.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:03:34 -0700 (PDT)
Message-ID: <5d577c96.1c69fb81.48f7f.43b5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0f2027f458f8b7f17acb024cf47082052f416805.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <0f2027f458f8b7f17acb024cf47082052f416805.1564091601.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 21:03:33 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-07-25 15:18:38)
> Printing the function name when enabling debugging makes logs easier to
> read.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

