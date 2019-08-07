Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9384F54
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbfHGPAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 11:00:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38962 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfHGPAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 11:00:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so41281058pls.6
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=KZ8uTQBbhCoVPVLq+C4BHS+Mf8ZC86MmMMrTG7ha+H0=;
        b=Jp0UtNZCC8cbLtwVC11RHbJ5sVa6xcn/gHKlJHfNoAjGid9R1Ro/fP956hygnVjnlx
         UXeRVeP6z12LPFFvwUt4MGsHKitKyDjNpezOtPUTkpdN8zJWkAx3Ky3KuJczrqCmKJPD
         BlsXtDa2l9ldljcENRwWPj+3XjCA6TNE+VAno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=KZ8uTQBbhCoVPVLq+C4BHS+Mf8ZC86MmMMrTG7ha+H0=;
        b=i28mA0Wfx21dC3ZPg4ZDKlhawHn816+ymZTk27J1DlXhIxaSFHDhcRv3XCEn0lTxNM
         SLT/w0A9BLGIo7g1w02ruwPpYFb2y3McXOn26jaRHaHiyefaJnX1TJhT5Z7azk1sN1Gh
         e9CzIC3NvS2defZBQQFbQJcQn24k322anzSXa9GWU1Z0foo8F+M6g6RxPDmuemoNK1a+
         AlUMjumFUve71Y2eYY8OWqnnq7FVGQA/3XFgie3qZJE/GWO1pZD5W6WBBkN34U48xVNs
         SM4Ycxsi9bRUSTWtl9tADos9TqyoAGYsJhOY1cziigna/eJfeqc7gGt6rvtbVuNm1CLM
         nBbg==
X-Gm-Message-State: APjAAAViwTHjmzDN9nl57N/EdBOkQNkEASXKpWiq90t6ivkFn/5uJch0
        TWCwUZWwAAKORJ+kKp/y9EHlng==
X-Google-Smtp-Source: APXvYqy2jxaSa12yeJ+hSX/nC2py2R6uMv7QFDeb3lys0otIzEa3uukW94IdpTYGAPXXXgF8jqwACQ==
X-Received: by 2002:a63:dc4f:: with SMTP id f15mr8183383pgj.227.1565190012942;
        Wed, 07 Aug 2019 08:00:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 143sm141606468pgc.6.2019.08.07.08.00.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 08:00:12 -0700 (PDT)
Message-ID: <5d4ae77c.1c69fb81.8078a.b6ba@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190807014846.143949-2-trong@android.com>
References: <20190807014846.143949-1-trong@android.com> <20190807014846.143949-2-trong@android.com>
Subject: Re: [PATCH v8 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 08:00:11 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-06 18:48:44)
> wakeup_source_init() has no users. Remove it.
>=20
> As a result, wakeup_source_prepare() is only called from
> wakeup_source_create(). Merge wakeup_source_prepare() into
> wakeup_source_create() and remove it.
>=20
> Change wakeup_source_create() behavior so that assigning NULL to wakeup
> source's name throws an error.
>=20
> Signed-off-by: Tri Vo <trong@android.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

