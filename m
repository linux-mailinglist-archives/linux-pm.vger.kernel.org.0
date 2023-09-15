Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049887A1472
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 05:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjIODhT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 23:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIODhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 23:37:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F1270E
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 20:37:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ef653af2eso113630985a.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 20:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749034; x=1695353834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIubZOhXnC08Ym5gC3EaH+E8b/9Z9IetgzoFovfcROQ=;
        b=hwG/VQhcFQEMzWhn5tv3Eg48tS092BPFcXsMmKbzySblC9Xl3brLHcED0PmNHfoHzw
         FyZw2C0pN0kcEIfEla++mG3MrkM3swRylt+gap3gmvHcDm2baoQtsa2+YI4dw6Yobpzg
         FfVx8fieSGW07jjyHYnV4snYlYBNQLRphbpco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749034; x=1695353834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIubZOhXnC08Ym5gC3EaH+E8b/9Z9IetgzoFovfcROQ=;
        b=hyJ3C2M6h76ddDZ+9An8AUZE/+z5HwlS5nVo+qGl7yTbC6qEexxpynHiBsNO5oMeSG
         4V4w9tdspFZkJ7XSNCBSh8bR5BJWNNUyfs/9FGh6PYBqUGmLKwW/gux1iFTiCVmFnJKR
         28AwDo7TgqKCWmyLSJ8j2reJ1STpcGY052fL7BieI1eFTovptgLd2UG9dYWh0qIBhHZj
         RkfDYnwbADaT6QWpXv1UHvYTrJiFF3vcPzfe9RDrHPqxi3ZWshj23WQPpC4IXr1PUtQE
         ErQ8eEsFj0NQmzbtN4XQASdpduJTu6nWH7pwF6SBJHHB3jyAty3mCIcc/b0PBGIunkXO
         HAXg==
X-Gm-Message-State: AOJu0YwFO3xab0su4ZdL/nbe3JSfIqCd1E72pWI6+uuftgtdseMnOtY0
        1rhVEeiHKDUwm0YVO6e8/i2f0w==
X-Google-Smtp-Source: AGHT+IHNdsenkQuTc4rELGiZbigK/KFy8HJv9f8XOH9URiKwnYv/ZvSBXS2eE9iNS+cof6JoKwYupw==
X-Received: by 2002:a05:620a:29d3:b0:76f:1eac:e72d with SMTP id s19-20020a05620a29d300b0076f1eace72dmr477359qkp.38.1694749033852;
        Thu, 14 Sep 2023 20:37:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff16-20020a056a002f5000b0068fedfe01fesm2011980pfb.161.2023.09.14.20.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:37:13 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:37:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cpufreq: refactor deprecated strncpy
Message-ID: <202309142037.DAF02CD00@keescook>
References: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 13, 2023 at 12:07:21AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Both `policy->last_governor` and `default_governor` are expected to be
> NUL-terminated which is shown by their heavy usage with other string
> apis like `strcmp`.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

All looks sensible to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
